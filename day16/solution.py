import sys
import enum
import math


class PacketType(enum.Enum):
    SUM = 0
    PRODUCT = 1
    MINIMUM = 2
    MAXIMUM = 3
    LITERAL = 4
    GT = 5
    LT = 6
    EQ = 7


class HexReader:
    def __init__(self, hexdata):
        cleaned = hexdata.strip()
        self.data = "".join(f"{int(ch, 16):04b}" for ch in cleaned)
        self.datalen = len(self.data)
        self.cursor = 0
        self.version_numbers = []

    def read(self, n):
        """reads leftmost n bits of data"""
        result = self.data[self.cursor:self.cursor + n]
        self.cursor += n
        return int(result, 2)

    def read_packet(self):
        if self.datalen - self.cursor <= 0:
            return None
        packet_version = self.read(3)
        self.version_numbers.append(packet_version)
        packet_type = PacketType(self.read(3))
        if packet_type == PacketType.LITERAL:
            value = self.read_literal_packet_value()
            return value

        subpackets = self.read_operator_packet_body()

        if packet_type == PacketType.SUM:
            return sum(subpackets)

        if packet_type == PacketType.PRODUCT:
            return math.prod(subpackets)

        if packet_type == PacketType.MINIMUM:
            return min(subpackets)

        if packet_type == PacketType.MAXIMUM:
            return max(subpackets)

        if packet_type == PacketType.GT:
            a, b = subpackets
            return int(a > b)

        if packet_type == PacketType.LT:
            a, b = subpackets
            return int(a < b)

        if packet_type == PacketType.EQ:
            a, b = subpackets
            return int(a == b)

        raise Exception(f"Unhandled packet {packet_type}")

    def read_operator_packet_body(self):
        length_type_id = self.read(1)
        subpackets = []
        if length_type_id == 0:
            total_length = self.read(15)
            operator_packet_end = self.cursor + total_length
            while self.cursor < operator_packet_end:
                subpackets.append(self.read_packet())
        else:
            num_subpackets = self.read(11)
            for i in range(num_subpackets):
                subpackets.append(self.read_packet())
        return subpackets

    def read_literal_packet_value(self):
        more = True
        value = 0
        while more:
            more = self.read(1)
            value <<= 4
            value += self.read(4)
        return value


def main():
    if len(sys.argv) == 2:
        fname = sys.argv[1]
    else:
        fname = "input.txt"

    with open(fname, "r") as f:
        hexdata = f.read()

    reader = HexReader(hexdata)
    result = reader.read_packet()

    # Part 1
    print(sum(reader.version_numbers))

    # Part 2
    print(result)


if __name__ == "__main__":
    main()
