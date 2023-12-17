import re
def entry(haystack: str, needle: str) -> tuple[int, int] | None:
    final_matches = []
    for i in range(len(haystack)):
        matches = re.finditer(("."*i).join(needle),haystack)
        for j in matches:
            final_matches.append((j.span()[0],i))
    return final_matches or None
