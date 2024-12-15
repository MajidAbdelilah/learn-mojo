from sys.info import simdbitwidth

fn main():
	x = 5 + 10
	print(x)
	matrix = SIMD[DType.float32, 8](1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0)
	print(matrix)
	matrix *= 2.0
	print(matrix)
	print(simdbitwidth())
	print(str_len("Hello, world!"))


fn str_len(s: StringLiteral) -> UInt64:
	result = UInt64(0)
	s_len = len(s)
	ptr = UnsafePointer(s.unsafe_ptr())
	while s_len > 0:
		if(s_len >= 64):
			result += ((ptr.load[DType.uint8, 64]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 64
		elif(s_len >= 32):
			result += ((ptr.load[DType.uint8, 32]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 32
		elif(s_len >= 16):
			result += ((ptr.load[DType.uint8, 16]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 16
		elif(s_len >= 8):
			result += ((ptr.load[DType.uint8, 8]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 8
		elif(s_len >= 4):
			result += ((ptr.load[DType.uint8, 4]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 4
		elif(s_len >= 2):
			result += ((ptr.load[DType.uint8, 2]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len -= 2
		else:
			result += ((ptr.load[DType.uint8, 1]() >> 6) != 0b10).cast[DType.uint8]().reduce_add().cast[DType.uint64]()
			s_len = 0
	return result
