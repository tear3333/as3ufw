package as3ufw.utils {
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.xml.XMLNode;

	/**
	 * @author Richard.Jewson
	 */
	public class ObjectUtils {
		private static var refCount : int = 0;
		private static var FORMAT_INDENT : int = 2;
		private static var TYPE_INFO_CACHE : Dictionary = new Dictionary();
		private static var CLASS_INFO_CACHE : Dictionary = new Dictionary();

		public static function toString(value : Object, maxDepth : int = 4, namespaceURIs : Array = null, exclude : Array = null) : String {
			refCount = 0;
			return internalToString(value, 0, maxDepth, null, namespaceURIs, exclude);
		}

		private static function internalToString(value : Object, depth : int = 0, maxDepth : int = 100, refs : Dictionary = null, namespaceURIs : Array = null, exclude : Array = null) : String {
			var str : String;
			var type : String = value == null ? "null" : typeof(value);
			switch (type) {
				case "boolean":
				case "number":
					return value.toString();
				case "xml":
					return "XML!=" + value.toXMLString();
				case "string":
					return "\"" + value.toString() + "\"";
				case "object":
					if (value is Date) {
						return value.toString();
					} else if (value is XMLNode) {
						return value.toString();
					} else if (value is Class) {
						return "(" + getQualifiedClassName(value) + ")";
					} else {
						var classInfo : Object = getClassInfo(value, exclude, {includeReadOnly:true, uris:namespaceURIs});
						var properties : Array = classInfo.properties;

						str = "(" + classInfo.name + ")";

						if (refs == null)
							refs = new Dictionary(true);

						var id : Object = refs[value];
						if (id != null) {
							str += "#" + int(id);
							return str;
						}

						if (value != null) {
							str += "#" + refCount.toString();
							refs[value] = refCount;
							refCount++;
						}

						var isArray : Boolean = value is Array;
						var prop : *;
						depth += 1;

						// Print all of the variable values.
						for (var j : int = 0;j < properties.length; j++) {
							str = newline(str, depth * FORMAT_INDENT);
							prop = properties[j];
							if (isArray)
								str += "[";
							str += prop.toString();
							if (isArray)
								str += "] ";
							else
								str += " = ";
							try {
								if (depth > maxDepth) {
									str += "max depth(" + maxDepth + ") reached...";
								} else {
									str += internalToString(value[prop], depth, maxDepth, refs, namespaceURIs, exclude);
								}
							} catch(e : Error) {
								str += "?";
							}
						}
						depth -= 1;
						return str;
					}
					break;
				default:
					return "(" + type + ")";
			}
			return "(unknown)";
		}

		public static function describeType(o : *) : XML {
			var className : String;

			if (o is String)
				className = o;
			else
				className = getQualifiedClassName(o);
			var result : XML = TYPE_INFO_CACHE[className];
			if (result)
				return result;

			if (o is String)
				o = getDefinitionByName(o);

			result = TYPE_INFO_CACHE[className] = flash.utils.describeType(o);
			return result;
		}

		public static function getClassInfo(obj : Object, excludes : Array = null, options : Object = null) : Object {
			var n : int;
			var i : int;

			if (options == null)
				options = {includeReadOnly:true, uris:null, includeTransient:true};

			var result : Object;
			var propertyNames : Array = [];
			var cacheKey : String;

			var className : String;
			var classAlias : String;
			var properties : XMLList;
			var prop : XML;
			var isdynamic : Boolean = false;
			if (typeof(obj) == "xml") {
				className = "XML";
				properties = obj.text();
				if (properties.length())
					propertyNames.push("*");
				properties = obj.attributes();
			} else {
				var classInfo : XML = describeType(obj);
				className = classInfo.@name.toString();
				classAlias = classInfo.@alias.toString();
				isdynamic = (classInfo.@isDynamic.toString() == "true");

				if (options.includeReadOnly)
					properties = classInfo..accessor.(@access != "writeonly") + classInfo..variable;
				else
					properties = classInfo..accessor.(@access == "readwrite") + classInfo..variable;

				var numericIndex : Boolean = false;
			}

			// If type is not dynamic, check our cache for class info...
			if (!isdynamic) {
				cacheKey = getCacheKey(obj, excludes, options);
				result = CLASS_INFO_CACHE[cacheKey];
				if (result != null)
					return result;
			}

			result = {};
			result["name"] = className;
			result["alias"] = classAlias;
			result["properties"] = propertyNames;
			result["dynamic"] = isdynamic;

			var excludeObject : Object = {};
			if (excludes) {
				n = excludes.length;
				for (i = 0;i < n; i++) {
					excludeObject[excludes[i]] = 1;
				}
			}

			var isArray : Boolean = className == "Array";
			if (isdynamic) {
				for (var p:String in obj) {
					if (excludeObject[p] != 1) {
						if (isArray) {
							var pi : Number = parseInt(p);
							if (isNaN(pi))
								propertyNames.push(new QName("", p));
							else
								propertyNames.push(pi);
						} else {
							propertyNames.push(new QName("", p));
						}
					}
				}
				numericIndex = isArray && !isNaN(Number(p));
			}

			if (className == "Object" || isArray) {
				// Do nothing since we've already got the dynamic members
			} else if (className == "XML") {
				n = properties.length();
				for (i = 0;i < n; i++) {
					p = properties[i].name();
					if (excludeObject[p] != 1)
						propertyNames.push(new QName("", "@" + p));
				}
			} else {
				n = properties.length();
				var uris : Array = options.uris;
				var uri : String;
				var qName : QName;
				for (i = 0;i < n; i++) {
					prop = properties[i];
					p = prop.@name.toString();
					uri = prop.@uri.toString();

					if (excludeObject[p] == 1)
						continue;

					// if (!options.includeTransient)// && internalHasMetadata(metadataInfo, p, "Transient"))
					// continue;

					if (uris != null) {
						if (uris.length == 1 && uris[0] == "*") {
							qName = new QName(uri, p);
							try {
								obj[qName];
								// access the property to ensure it is supported
								propertyNames.push();
							} catch(e : Error) {
								// don't keep property name
							}
						} else {
							for (var j : int = 0;j < uris.length; j++) {
								uri = uris[j];
								if (prop.@uri.toString() == uri) {
									qName = new QName(uri, p);
									try {
										obj[qName];
										propertyNames.push(qName);
									} catch(e : Error) {
										// don't keep property name
									}
								}
							}
						}
					} else if (uri.length == 0) {
						qName = new QName(uri, p);
						try {
							obj[qName];
							propertyNames.push(qName);
						} catch(e : Error) {
							// don't keep property name
						}
					}
				}
			}

			propertyNames.sort(Array.CASEINSENSITIVE | (numericIndex ? Array.NUMERIC : 0));
			// remove any duplicates, i.e. any items that can't be distingushed by toString()
			for (i = 0;i < propertyNames.length - 1; i++) {
				// the list is sorted so any duplicates should be adjacent
				// two properties are only equal if both the uri and local name are identical
				if (propertyNames[i].toString() == propertyNames[i + 1].toString()) {
					propertyNames.splice(i, 1);
					i--;
					// back up
				}
			}

			// For normal, non-dynamic classes we cache the class info
			if (!isdynamic) {
				cacheKey = getCacheKey(obj, excludes, options);
				CLASS_INFO_CACHE[cacheKey] = result;
			}

			return result;
		}

		private static function getCacheKey(o : Object, excludes : Array = null, options : Object = null) : String {
			var key : String = getQualifiedClassName(o);

			if (excludes != null) {
				for (var i : uint = 0;i < excludes.length; i++) {
					var excl : String = excludes[i] as String;
					if (excl != null)
						key += excl;
				}
			}

			if (options != null) {
				for (var flag:String in options) {
					key += flag;
					var value : String = options[flag] as String;
					if (value != null)
						key += value;
				}
			}
			return key;
		}

		private static function newline(str : String, n : int = 0) : String {
			var result : String = str;
			result += "\n";

			for (var i : int = 0;i < n; i++) {
				result += " ";
			}
			return result;
		}

		public static function merge(... params) : Object {
			var target : Object = params[0] || {};

			for (var i : int = 1; i < params.length; i++) {
				for (var key:String in params[i]) {
					target[key] = params[key];
				}
			}

			return target;
		}

		public static function set(target : Object, params : Object) : void {
			if (params) {
				for (var name : String in params) {
					//if (target.hasOwnProperty(name)) {
						if (params[name] is Function) {
							target[name] = params[name]();
						} else {
							target[name] = params[name];
						}
					//}
				}
			}
		}
	}
}
