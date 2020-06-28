extends Node

func inc(value=1):
	return "$inc=" + str(value)

func dec(value=1):
	return "$dec=" + str(value)


func merge_dict(dest, source, strict=false, err="Key not defined"):
	for key in source:                     
		if dest.has(key):                  
			var dest_value = dest[key]     
			var source_value = source[key]        
			if typeof(dest_value) == TYPE_DICTIONARY:       
				if typeof(source_value) == TYPE_DICTIONARY: 
					merge_dict(dest_value, source_value, strict, err)  
				else:
					dest[key] = source_value 
			else:
				if str(source_value).substr(0,5) == '$inc=':
					dest[key] = dest[key] + float(str(source_value).substr(5))
				elif str(source_value).substr(0,5) == '$dec=':
					dest[key] = dest[key] - float(str(source_value).substr(5))
				else:
					dest[key] = source_value
					 
		elif not strict:
			if source[key] == '$inc':
				dest[key] = dest[key] + 1
			elif source[key] == '$dec':
				dest[key] = dest[key] - 1
			else:
				dest[key] = source[key]
		else:
			push_error(err)
