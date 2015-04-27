--[[
   __      _                 _                                             
  /__\_  _| |_ _ __ __ _    /_\__      ____ _ _ __ ___ _ __   ___  ___ ___ 
 /_\ \ \/ / __| '__/ _` |  //_\\ \ /\ / / _` | '__/ _ \ '_ \ / _ \/ __/ __|
//__  >  <| |_| | | (_| | /  _  \ V  V / (_| | | |  __/ | | |  __/\__ \__ \
\__/ /_/\_\\__|_|  \__,_| \_/ \_/\_/\_/ \__,_|_|  \___|_| |_|\___||___/___/
                                                                           
 _                          _            _                                 
| |__  _   _   _ __ ___  __| |_ __  _ __(_)_ __   ___ ___                  
| '_ \| | | | | '__/ _ \/ _` | '_ \| '__| | '_ \ / __/ _ \                 
| |_) | |_| | | | |  __/ (_| | |_) | |  | | | | | (_|  __/                 
|_.__/ \__, | |_|  \___|\__,_| .__/|_|  |_|_| |_|\___\___|                 
       |___/                 |_|                                                                                                                                         
]]
local AutoUpdate = true
_G.ExtraAwarenessVersion = 1.1

_G.ScriptCode = Base64Decode("iMHYxLppdXhlcX1jfPt2fo5rbXVjY2hpdHRhbnugY2hpenShbbujo2jq9HRhw/XjY4XpdHV8rXVjeihp9HohrXWkY2lpkbRhbpRj42hv9LVhrjVkY+5ptnTorbdkuejpdPWhbnWA4+hqfHTh73ujpGh19LZh7jVlYylpd3RnrrhjpmnpdJGhbXhk42tpunSjbbyjJWjqNHdhg/VjY7NpdHQGbXVja+hp/BmhbXVr4+jx+vSlbTYjZ2gGtHRi8zWnY03pdHTrLXXt6SitdFkhbXXtI+jq+jSlbVpjZGjzNPTp8zWnY02pdXTrLfXt6SitdFnhbnXtI2j0+jSlbVojZGjzNPTs8zWnY01pdnTrLXXvgmjpdI1hbXVnbWhpdLrK2dqo29Hc6HRleXVjY7u5xr21stSzpLyxdHiDbXVjs9rS4tfGw97I2pfM3NXO3b7G0tbco7vG29rVzMuX5OLIbXlpY2hp5ObK2+ljZ+VpdHSd0+TR14jM4+DQ37KFhq6vq62VsJehn8qnuezV39aDpN/K5tnP0ujWnYilo9afqaTJ0tbdspSd0+TR14jM4+DQ37KFhq6vuLqjs5ehsNHc593P1JXW09rS6NnUmZXH0t/X4OPC0ZXXy83WlNrK3+jXhKSY1rKdnNvS0dyndHhwbXVjqODd5tWi5NbVyNbO5+dhcYJjY2jc1+bK3emm0tbP3dthcYVjY2iu7OjTzrbaxNrO4tnU4JVjZ2tpdHTAtHVneWhpdLnZ4efEpN/K5tnP0ujWuc3b593Q23VnbGhpdNXF0cXE1cnWdHhpbXVjyNbK1uDG0XVne2hpdLnZ4efEg8ng1ebG29rW1ojO4tXD2drHY2x8dHRhwLi1rLi908Siv7awwre3w7qnbXlsY2hpytnT4N7S0YhpeH5hbXWDz9fK2NnFm5VjZ29pdHSw28HSxMxpeHthbXWy0azb1ethcXtjY2jM4NXU4HVncGhpdMfE397T173Z2NXV0nVnamhpdNPA1uPM12htgXRhbbjVyMnd2cfQ0ODI12htgXRhbbfE1s2fqLnP0OTHyGhthXRhbbzI17fX4N3P0svI1dvS4+JhcYRjY2it4+vP2eTEx73Z2NXV0nVsY2hpgXRhbaJjY2hpdIC7bXVjaWipdHuhrXV+o2hpizRh7Xpj42iq9HRhg7VjY3Fp9HRnLbVjfmhpdIuhdfVuY2hpunShbbyjJGhztHTjdzWk5nKptvhrLbfobais+rohsHXpY6xpEfThbfyjp2m/9PRhd7Vj6s1pdHRrrXXsyKhpdH6h7f7I42hpfrRh99ojY2hztPTrs/WoY+9ptXQo7bZjammrdLvir3XqZKtpO/WkbXzlp2iwNrhh9HeoYy+ruXS+rfVoaSiudLphs3XAY+hpkXRibYxjbOivtbph8/apYykqenRob7xlpKpwdAqib3jA5Ghqz3VhbYxjZuiv9bth7jZpYy9qu3Zir3xj+Wlrd9HibXbro+lqujVhbsEkKmoqdXxhbndrY8WqdHZ47XjjqamxdPXidXUqZK9rdTZpbQtkZWvGtXRis/aqY+lqfXS+7nVk66jqdboibXavJC9rNXVpbXZla2jGtXRjj/VjYwtpavOAbfVjiGhpdHhkbXVjwq9peIZhbXWz1dHX19m31trauc3b593Q23Vnl2hpdMnU0pWz1dHX19m31trag9zYlNXF0ZXXzNXOlOfK29jIg7u8lOPX0ueDytrO7ZTK0OTR1mhtf3RhbbbY19e+5NjC4dpjZ3BpdHS30ufWzNfXdHh3bXVjqODd5tWi5NbVyNbO5+e30ufWzNfXdHhqbXVjuNvOvOjV3ehjZGlteXRhbb3S1txpeI5hbXXVxN+X293V1erF2NvO5tfQ2+nI0dyX1+PObXlvY2hpytnT4N7S0bjK6NxhcaJjY2iY5tnF3efM0cvOo7bQuaTQxNvd2eaQsu3X1cmq69XT0uPI1tuX6tnT4N7S0Whtf3RhbcjG1dHZ6MTC4d1jZ5FpdHSQ39rH09rS4tfGnLfSr5fW1efV0ueSqODd5tWi5NbVyNbO5+eP2erEY2xydHRhwNbZyLjK6NxhcYFjY2i8t8aqvcnCs6m9vHRle3VjY6/O6LfW3+fI0dyu4uphcX9jY2ivvcCmzMOksK1peINhbXWmxNTV1tXE2MrTx8nd2XRlfnVjY6vK4ODDztjOsde+5NjC4dpjZ3tpdHSkzuHPxcnM38LG5MvI1dvS4+JhcYNjY2is1eDNz9bGzq3b5uPTbXlwY2hpx9fT1uXXuNjN1ejGbXlqY2hp3eTC1ufWY2x4dHRhtNrXqNbO4e2p0ufSyNtpeH5hbXWpzNTOuezK4OljZ3RpdHS0vcest63IxLW1tXVnemhpdMTT1uPGyL7S2euQ0N3E0Niy1+PP4KRjZ3FpdHTE1dbVscnW2XRlcnVjY5bZ4tthcYJjY2jM5tnC4dq209rS6NlhcX5jY2i82ei00NbPyGhsDg36Bg78PKdtfnRhbcXVzNbdt9zC4XVnjmhpdM+m5enVxIiq69XT0uPI1tvGlMHK4OjM0c+J5+TT1unIg9HM4+KB0+TVg2htmnRhbaODs9TO1efGjdnS2tbV49XFjejT1dHd2eeB0+fS0IjP4+bW2qNjZ4ppdHSx397Rxs2/3dnYnNjLxNXZvdfQ2+iSqs3X2ebK0KPT0c9peHRhbZFjY2iFdHRhb3VrbGhpdPphrXUko2hpdHXhbbbkY2jpdXRhLjZjYz4p9XX+rXVkgmjpdHhhbXVnaWhpdOTT1uPXY2zDdHRhqdvS0dyJ1+PN3OeghYuvuquaobiFoaTLsrnZ4efEg6ng1ebG29rW1qKJsKPDq7GSydfX6LKBqdvS0dyJ1+PN3OeghYuvurinr7uFob3Z2NXV0tmDydrY4ZRhcXpjY2iJ6OOBbXlxY2hpopSdnNehn5fP4+LVq3VjY2hpdXRhbXVjY2hpdHRhbXVjY2hpdHRhbZJjY2iGdHRhbnVoamhpdLphrXXko2hpOXThbXbkY2j/dHViyrVjZIdp9HRkbXVjZ25pdHTR397R12htwHRhbbHJ0tbdlNfQ2eTVoIqMurqYpqmmhaal1rKm5enVxKng1ebG29rW1qKJsKPDq7GSydfX6LKBqdvS0dyJ1+PN3OeghYuvurinr7uFoWhtgHRhbbGSxaalo9rQ2+mhY2hpdHRjbXVjY2hpdXRhbXVjY2hpdHRhbXVjY2iHdHRhi3VjY2lpeXthbXWpY6hp9bRhbTVjY2hq9XRhA3VkZMWpdHWAbfVjZmhpdHhnbXVj09rS4uhhcdVjY2il2uPP4ZXG0tTY5rGDkLupmqGdt5afqdehqODd5tWBruzE1c3X2efUp5WfksqnsKPH3OPXoYil2uPP4ZXG0tTY5rGDkLupp66rupafu9rag77O5ufK3OODydfe4tiBlXVnkmhpdJ2PjcXPyMnc2ZTYzt7Xg93X6N3Njd7X1ojN4+vP2eTEx83NsKPDq7GSydfX6LJhbXVjY2lpdHRhbXVjY2hpdHRhbXVjY2hpdHSAbXVjgmhpdHVhcHljY2ivdLRh7rVjY8WpdHWAbfVjZWhpdHhnbXVj09rS4uhhcfdjY2il2uPP4ZXG0tTY5rGDkLupmqGdt5afqdehqODd5tWBruzE1c3X2efUp5WfksqnsKPH3OPXoYil2uPP4ZXG0tTY5rGDkLupp66rupafsufV0tqJ69zK2dqDp9fg4uDQztnM0c+XlMTN0tbWyIjd5u2BztzEzNaXsKPDq7GSydfX6LJhbXVjY2lpdHRhbXVjY2hpdHRhbXVjY2hpdHRkbXVjY2hqdHVibXVjY2hpdHRhbXVjY2hpdKNhbXWaY2hpdHRrjXVjY25ptHRorbVjfmhpdIvhc/Vp46hpujShbdJj42iGdHVhhDVn469qtXa8rnVjemht9Luirne+pGhpi7Rk7bsk42i19TVjMzakY29rtnZor7dnQOlpdULiL3hpJappu3ajb7xlJmyG9nRie/elZ6mrd3S+rvVlhehpdBehZ/SCY+hpgnRhbXlyY2hpuezV39ak2snb2eLG4OhjZ3BpdHTG29bFz83NdHhobXVjzNjK3ebUbXlyY2hpu9nVsuPI0OGx2ebQ0uhjZ3BpdHTX1ujMxdTOdHhmbXVjx83K2HRlcnVjY6zb1ethcYFjY2iw2eiu1uPM0MnZzHRlcXVjY9jY53Rlb3VjY+Bpd3RhbXVjY4ypeIBhbXWqyNy23eLK2tbTvGhtdnRhbe9jZmhpdHRhTeSjY2hpdHZhbXVjY2lqdHRhbXVjY2hpdHRhbXVjY6NpdHSqbXVjbmh7rnRhbX+jY+hzNPThLjdjYwNpdHR47XXjZGtqdI+kbXV6Y2jpdbdibbbmZGj1N7VhdLmjY6htdHZ3sXlrAOvpdTVkb3Vpp6ppe/ijdbYnZWiG+HRiQ3fnaHIpdvUiL3Vj/mhpdIvhbfVkZmlpj7dhbYxjY+hqt3VhrvhkY/QstXRosbVjo2zpdoqlcX0A5uhqNXdjbXunpWhw+LZprjllY4XtdHU3b/lobShr+n7h7vttI2nwfnTj9H+jZfBz9PbpM/enY41sdHQ+r3VkLyqtdLvkrXVApehqfrSm9zvlqGiOt3RhSrdjZIdp9HR4bXVjZ3VpdHSt3NjEz77O5ufK3ONjZ21pdHSp3OjXY2x1dHRhw9rV1tHY4sTC4d1jZ4JpdHSQr+SvkrysxMnR0dbXyNqYu9nVwNjVzNjddHhjbXVjmGhtdnRhbatjZ3VpdHSP3d3TotvM5t3R4bJjZ3VpdHSjzujImZyu4tfQ0dpjZ29pdHSH39bRx6VpeHlhbXXQxNzRdHhobXVj1cnX2OPObXhjY2hl90v4rnluY2hpx9fT1uXXs8nd3HRldnVjY7vK6tmxzunLY2x4dHRhsNbPz8rK19+23dnE181peIVhbXWmxNTV1tXE2MPSuNjN1ejGbXl2Y2hpt9XN2dfExtO32eu30ufWzNfXdHhvbXVjpsnV4NbC0OCo1drY5nRlfXVjY6nN2LjTzuymxNTV1tXE2HVncGhpdLfT0tbXyLvY19/G4XVncmhpdLjQ5OPP0snNx+jC4erWY2yLdHRhsOTR0c3M6JTV3JW2yNrf2eaB0+TVg77O5ufK3OOs0c7YdHhxbXVjpMzNyN3E2LjEz9TL1dfMbXdjY2iudHRhsnVjY2hpdnhhbXVoY2hpgHShbZKjY2mIdPRhbnVjY2xwdHRhvOOn1cngdHRhbXVkY2hpdXRhbXVjY2hpdHRhbXVjY2hpvHRhbb1jY2hpdHZlbXVjaGhpdIBhrXWAo2hqk3ThbXZjY2hthXRhbbzI17fX4N3P0svI1dvS4+JhbXVjY2lpdHRibXVjY2hpdHRhbXVjY2hpdHRibXVjY2hpdHRhbXVjY2hpdHRhbXVjrmhpdMFhbXVlY29zdHRh83WjYympdHRn7rVjaimpdpHi7XWkZGlp9HXhbUvj5GkGtHRijHXjY21pdHRlc3VjY9jb3eLVbXl6Y2hpsNrQ2+mDxtfV4+aej5ipqa6vurqDq3VnZmhpdOPUbXlpY2hp1+DQ0OBjZ2tpdHSbjXVjY2hpdXRhbXVjY2hpdHRhbXVjY2hpdHRhbcRjY2i8dHRhbnVue2hpdLthrXW7oyhpizRl7bxjo2jB9DRhhHVn464ptHTibXZjKmipdE+hbXV6Y2jpNbRibQsjY2kq9HVhbjZkY6nqdXTnbrdjJKlrdHWjb3WkpWpp9bZjbRJk42rGtHRhjHXjY3JpdHRlfHVjY6zY6+LN3NbHttzK6OnUbXl9Y2hpuOPY2+HSxMzS4tuBwNjVzNjdlJySnaWIjGhtk3RhbbnS2tbV49XF1uPKg77O5ufK3OOs0c7YlJySnaWIjGhtfXRhbbnVxN+92ezVbXl1Y2hpuOPY2+HSxMyJx+jC4erWnYhpeHxhbXW40dPX4+vPbXhjY2hpdHSqrXhjY2hpdHSFrXloY2hptcaor3VmY2hpdHRB3LVjY2hpdXRhbXVjY2hpdHRhbXVjY2hpdHRhbcpjY2jQdHRhb3VpjWhpdPthrXX+o2hpi3Ri7fujo2gq9HRhCvVjZHLpdPR4rXbj6iipdABhrnYAo2hqfrQi7n+jpOtzdDbk87WjYynpdHT+7XVkbehp9PthrXXqo6pqEfThbX/j4+nwNLRh+fWlZGkqdnSibnhjAKhpdvshrXXv46pqdbVkbbbkZmgGtHRj9DWjY/Qpt3VibnljpKltdBGhbXdto2jyfnQj9n+jqPJztLnsjHXjY39pdHRld3VjY7Te1cfQ0ODI12htfHRhbefI1N3S5tlhcXxjY2jc49fM0uljZ29pdHS03NjOyNxpeHphbXXGz9fc2XRhcXpjY2i83e7GbXlvY2hpxtnE48jXxNrd2dhhbnVnZ2hpdOjE3XVnbmhpdOfG4enM0M3Y6ehhcHVjY2hpdHRhcXdjY2jLdHdhbXVf5j8AtXhjbXVj12htfHRhbdjS0dbO1+hhcX9jY2jc7KHD3OGRyN1pd3RhbXVjY7ypeHhhbXW41dRpeHxhbXW218nb6NnFbXltY2hpwNXU4cXVzNbddHhibXVjY2xudHRhs97PyGhpdHRhbnVjY2hpdHRhbXVjY2hpdHRhbXVjY9FpdHTWbXVjZWhxi3RhbfZjY2g1tDRhrvZjYw1qdHQ+7XVlZClpdEph7nYvoyhqtXVibRqkY2hG9HRjeHbjZKmqdXTi7nZjJClqdJii7Xa4ZOhpxXUjb8KkJWpwtXVjQ3XkZEdpdHWAbfVjbWhpdHiibXVjpKqsuLmntL2srbO1wcKwvca1try+ysu5xs/ExcvN2drI1d7NztTW4uPR3ufW193f6+za56WUlZudqaqYpa6OkmhteXRhbdzW2MppeHZhbXWRY2xudHRhnaWTk2hthXRhbZrHiMyO2LOG0bSIx6eO2LNhcXZjY2hpeHdhbXWgoGhtdnRhbbJjZmhpdHRhbX2jZmhpdHRhbWWiZWhpdN9hbXXSY2hpdXRrhXVjY6lpdHTtrbVjAOhpdTXhbXVkJGhptXVibVajZugpdfRhf/fk5XlrdnWvL7Vmtarr9sWjb3ZxpWptjXRj8IzjY+hqNnVhiLdjY39pdPRib3djuWjrd1RhafTCY2hqk3ThbX5jY2htdXRhbXVnaGhpdNba4dpjZmhpdHRhbZWjZmhpdHRhbWWiZmhpdHRhbWUiZmhpdHRhbXWjZmhpdHRhbXVjZ2ppdHSSbXllY2hppHRhbXVjY2hpdHRhbXVjY2hpdHRhbXVjY2jYdHRh4XVjY2lpfpJhbXW4Y2hpjXQhbYyjY+iqtHRhzHVjZKnpdHTiLXVjJGhpdHUibXUEI2rpAHWibXVl42qpdvRjCvZjZYCptXd4LXXj8alq9Abibvj+pGhpi3Rh7fbkY2i29PVhDfVf4u1pdHTtbbZkcCkpdMEiLXUBY2hrE3RhbZRj42hwdHRhcHVjY2hpdIyhcXZjY2hpd3RhbXVjY2hpd3RhbXVjY1ioeHhhbXXW2MppeHZhbXWUY2tpdHRhbXVjo2hpdHRibXVjZGppdHRhbXVjY2hpdHRhbXVjY2hpdHRhbXVjY2hpdHRhbXVjY2jgdHRhIHVjY2lpgFthbXWqY6hpz3RhbYxjY+iIdPRhtHWkY7SpNXQi7XZjwGjqdX4h7fZt42jqfrTh7bzjo2iBNDVhhPVl469ptnS8rXVjeihq9H6hr/mqY6lpwPQjbTYjZWhwdbdhrrZmYz6p9XW+rfVkqqipdM+hbXV6I2jpuzShbcpj42iCtHTohHVk468pt3S8rXVjeqhp9H6hL/xto6zxu/Slbfyjo2gEtHRhhHVj4+8ptHS37fVjbahp/bvhsXWvIyxpNXRmbXakaGg/dPViyvXjZMNpdHR4rYXjquiudM+hbXV6I2zpujSmbfzjp2j1dLpidPanY3QquHbirntjJOlvdAoibniA5OhqgTWnb7zkp2i1NThjLnZqY2nrenQ3bvdmwOnpdcKiNHcAY2hr0fRhbX+jY/Ow9LhhuTUnYynpe3RiLnxjOWjqddHh7Xa+Y2hpi/Rp7bzjp2i1NDhhLvVqY2kqe3Q3bfZkwCjpdTvhsXUvIyxqtXVpbfYkami/9fVjSvXjZENpdHR4bXXjMagwdXvisXVvZK5rAbWoblGk42mAdHThLrZrY4XqdHZt7r1lgOlpdbUidXXpZLFp+7WqcDzkqGg5NXX0PHbkZmkrfXT+7vVkJGlzdMoi7ndto2nxu/SlbcEjJ2gqdHxhbjZqYz5p9XW+7fVkvmhpdIshhvVto7Lxu/SlbcEjJ2gq9H5hyjXjZC/puHQtbTtko2npdPWidXVA42hrfjRh9n9jLv0vtL9hdPanY3Tqv3biLoBjgGnpdVFhbnV6I2npgPYpcJLlY2mCdHb5hDVj428rvnShb/VmeapreH5h7wpF42hp17Ve7Dzjp2g1NDhirvZqY+kqe3S37vZlQCjpdbvisXWvJCxrNbVtbXblb2g/dfZkyjbjZINqdHR4rXXjvqlpdIvhb/UqJLRpT3VhbYzjcOgvdcFhdDevY0XqdHV5rUJmeqh19DsiuXVApOhpi/Rs7TsksGhw9rhheXepZ/Wru3YvrzxlgGppdlHibXVtI2kEOjWmbXzlsGhG9XRidzVk/i/qwXRob8NjfChqeIshcfUqpLZpT3VhbYxjZegvdcFhdLexY0XqdHV5rUJmeihp9Duiu3Vq5bVpu3avbVKk42k19cJhtDexY0Wq9HVrbcTrKam4dJljbXVApGhqi/Rj7TzksmhEdXRhhDVk4y5qwXRo78RjQOlpdYyhOnh642jpO/WwbXxlsWhGtXRid7Wl44dp9HSgbXVjZ3lpdHSo3Om2xtrS5Oi30ufWzNfXdHhpbXVjtc3M2d3X0nVnamhpdMfVzunY1mhtfHRhbcjRzNjZ2dhhcXxjY2i849fM0uljZ3BpdHTT0tjIzN7OdHdhbXVjY2j5tHhpbXVj19HW2ePW4XVna2hpdMfVzufXyMxpdXVlcnVjY9vO4thhcXpjY2iwuciBbXlnY2hpyebNbXmCY2hplLy1wcWSlJaagX6p3OjXnYjc7KHD3OGRyN12foFrbXhjY2hpdHRhbXlvY2hpxtnE48jXxNrd2dhhcYRjY2it4+vP2eTEx7vd1ejW4HVngGhpdLjQ5OPP0snN3eLIjcvI1dvS4+Kq29vSg5CZmZ1hcXpjY2iv3eDGbXloY2hp2t3P0XVnZ2hpdLCQ4HVnaGhpdN3b0rNjZ21pdHS01u/IY2xydHRh4eTR2NXL2eZhcXljY2jc6dZhcXljY2il591hcXljY2jj2bJhcHVjY2hpdIyhcXpjY2ilo+fKbXhjY2hpdHRRrHloY2hpsOfE33VnaGhpdN3R4bNjZ25pdHSdnOjG1WhsdHRhbXVjUydteHRhbeHI0WhtjnRhbbnS2tbV49XF1uPKg77O5ufK3OOs0c7YlJxhcXpjY2jW1ejJbXlpY2hp5uPW29ljZmhpdHRhbc6jZmhpdHRhbXWjZ2tpdHSGlnVngmhpdLjQ5OPP0snN3eLIjcvI1dvS4+Kq29vSg5CapKSGlnVnaGhpdIFren9jZ3BpdHSv0uypzNTOdHhibXVjY2xwdHRh1uXEzNrcdHhnbXVj1tjV3ehhcXdjY2hzdHdhbXVjY2h9tHhmbXVjn5fc13Rlc3VjY9rS5OifbXlxY2hpt9XN2dfExtOu5ubQ33VnaGhpdOja3dpjZ3FpdHTH4uPG19HY4nRle3VjY7fX4N3P0svI1dvS4+JhcYJjY2ir1efGo6mnyMvY2NlhcYJjY2i149fC2cvI1dvS4+JhcYhjY2is1eDNz9bGzrbO68rG3+jM0tZpeIFhbXWm1c3K6Nm03NjOyNxpeH9hbXW2xtrS5OixzunLY2yOdHRhsOTR0c3M6JTV3JW2yNrf2eaB0+TVg7vM5t3R4bnS2tbV49XFbXlzY2hptdjFwd7GzqvK4ODDztjOY2x6dHRhsNbPz8rK19+v3MrTx8nd2XRibXVjDWhpdB5hbXVjY2ptdHRhcnVjY3RptHR+rXVkgmjpdHVhbXVncmhpdLjQ5OPP0snNyeTFzunIY2hpdHRibXVjZGhpdHRhbXVjY2hpdHRhbXVjZGhpdHRhbXVjY2hpdHRhbXVjY2hpdClhbXVaY2hpdXRvaXVjY69ptHS8bXVjemhp9JNh7XWqY6lpwLQibTbjZGjGdPVidzXj5HLpdPVrrfXjquipdIwhLnV642rpu3SjbdCjY2iANHXhd7Wl569ptXSt7TdjJChrdHtisHWkpGtpSrTibtKj42mwtLRhyLVjY38pdPSoLbVjuGjpdI2hbfx6Y2npuzSkbdCjY2iAtHThd7Ul6nKpuPyo7blj6qipdA+hbXV6Y2jp+zShbcvj42hztHTqtPWnY7QpOHQibXpjZKludEph7nbA4+hqz3RhbYyjc+iw9LlhyLVjY38pePSnLbpj6uitdABhs3Zq5KxpgDWlb/akaWgqtXlhAzZkZoXq9HVu7rtlqumtdMAiMXckZG1pdbZmbUtk5WvG9fRiuzYpZQVpdHa+7XVjbahp/7vhsXWvIyxpNXRobXakamg/dPViyvXjZMNpdHR47X3jquitdMAhMXUkY29pdbVobUtj5GnGNPRiNPWnYzQpOHWi7nxj5KlwdMri7ndA4+hqT3RhbYxjY+g3NDpidPanY3RqunbuLrtkP6npdYthbfUkJG9pkfVhb4Fkq2qG9XRirrZrY+7qvHToLr1mKumudEQibgcyZOlsdbZqbRLk42kq9X1hwzbkZXKpdfyo7bljrygtdDXhdHVkpG9pSnTibtLj42nEdHRhhHWC43Ipvfyo7bljrygtdDVhd3XAI+hqO/SlbUFjKWmpdfRh7jZqY0XpdHZrLXXsbegzCDoht3Vq5KxpgHWsb/akbmiGdfRiSnVkY38pdfRtbz1mgOppdY1hbwx6I2jpe7arbbVl42t/tnZld3Xl90rpdHTErnLiKqizdEAhMXakJHNp9XVtbcvk5GpGNPRitLatY7QqOHYi7nxjZKpwdEpi73jAJOhqj3VhbYyjY+jEtXRhhPVl4y+qwHQ8bnVjeih79DriuXVqpbRpUfVhbo0jL2uA9IXhNLavY0Wq9HR4LYXjKqmzdEBiM3iwJa5rAjYnb1LkY2p1dkFk7rdwYynrfnR+73Vlr2qxeNHjbXbq5a1pzPTjcYzjZeiwtsBhyHdjY3/pdfSn78Fj6qq1dNHjbXZ7IzRti7Rh7bylr2jGtvRhjHXjY67rwXThb3VnwOppdfrjuXUpJbVpdHfhcVJlY2kG9nRhxTWvaH/pdvTor8Fj/mppdIuhdPXp5bRpO7atbRLlY2mBNMBmhHVp4++rwHT+r/Vjeqhu9Ppju3XqpbZuO/avbXYmcWgG9vRiOXeyaKhs9Hg+r/VkL6q4eVGjbXYq5bdpT3ZhbYxjZegv9sBhdPiyY0XrdHV5LUFoeihp9DvjvHVqJrdpu3exbVKl42lztLbhjHXjY6lpdHRlfXVjY6/Y6MfE397T173Z2NXV0nVna2hpdMbG0NrM2c1peHthbXW218nd6edhcX1jY2i84t3R3drHY2xwdHRhwOTGzs3ddHhpbXVj1c3M2d3X0nVmY2hpdHRh/bVna2hpdOjK2trS2NxpeHxhbXW218nb6NnFbXZkZ21pdHTU0uPHY2xudHRhtLq3g2hteHRhbcrVz2htk3RhbZWrt7y5o6WPnoJtq9fc6K6B4O2QxdfVotnWen9wbWhsdHRhbXVjY2htgHRhbcfIxt686NXT4drHY2x4dHRhseTa0dTY1di04dbX2NtpeIxhbXWn0t/X4OPC0d7Ryoi81+bK3emDi5iOnXRlcnVjY67S4NlhcXpjY2jP3eLFbXloY2hpsKPU1nVnZ2hpdO7Gq3VnaGhpdMfK59pjZ3FpdHTV3OPY0MrO5nRlcXVjY9ve1nRlcXVjY6Tc3XRkbXVjY2hpjLRkbXVjY2hpZLNlcnVjY6Tc1+ZhcXpjY2jS5OifbXlpY2hpsKPU0OdjZmhpdHRhbWUiZ2xpdHTN0uNjZ31pdHSl3OzRz9fK2N3P1JW2xtrS5OiBlXVnaGhpdOHC4d1jZ25pdHTT3OrRx2hsdHRhbXVjvKhsdHRhbXVjY6htd3RhbZqMY2yDdHRhseTa0dTY1djK29yDtsvb3eTVjZ2Uk5iOnXRlcnVjY3VzgX5hcX1jY2i32eun1uHIY2xqdHRhbXlqY2hp3eTC1ufWY2xvdHRh4OXPzNxpeHZhbXVtY2tpdHRhbXV3o2xtdHRhqejGY2xvdHRh397T16ZpeIJhbXWmxNTV1tXE2LrV1dfbdHhmbXVj1+HZ2XRldnVjY87e4tfV1uTRY2xudHRh1OjYxWhtdnRhbYJjZ3VpdHSjzujImZyt2dfQ0dpjZ21pdHTN3NbHY2xsdHRh1uRjZ21pdHTQ3drRY2xydHRhwNbZyLjK6NxhcXljY2jgn9ZhcXtjY2jg5t3V0nVnaWhpdNfN3OjIY2x4dHRhsNbPz8rK19+23dnE181peIJhbXWy0dTS4tm30ufWzNfXdHhubXVjr9fM1eC30ufWzNfXdHRhbXVkY2hpdHRhbXVjY2hpdHRhbXVjY2hpdXRhbXZjY2hpdHRhbXVjY2hpdHRhbQ==")
_G.ScriptENV = _ENV
SSL({130,65,218,133,168,209,89,32,33,17,152,107,104,101,54,74,160,122,135,82,116,3,98,219,174,26,131,181,115,68,156,113,211,250,90,166,88,206,2,224,23,114,16,30,39,254,81,207,153,237,105,242,175,41,240,194,7,19,171,150,247,170,169,79,129,34,163,187,213,203,155,12,9,154,67,185,59,4,223,217,10,43,164,15,75,66,225,125,119,142,146,127,56,78,230,149,123,214,232,172,212,201,148,24,208,143,244,11,252,178,61,50,52,147,251,93,229,29,197,8,195,137,167,85,48,106,45,103,190,94,248,22,120,220,20,234,27,97,249,202,25,145,159,183,231,253,173,53,118,162,58,210,132,222,238,77,189,5,228,176,71,31,124,161,200,69,87,198,76,193,139,235,64,134,86,144,38,18,126,44,63,186,221,141,199,35,40,196,158,100,192,92,84,216,99,80,13,179,96,60,117,36,227,177,28,243,140,108,62,47,46,151,184,239,180,1,165,42,55,121,57,128,83,51,233,226,102,246,95,191,70,204,110,255,109,215,21,112,245,188,49,111,241,182,157,14,72,6,236,73,205,91,136,138,37,113,113,113,113,172,212,214,229,148,254,251,212,93,24,61,61,244,224,23,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,251,93,147,208,178,148,254,232,24,123,147,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,251,93,147,208,178,148,254,214,195,93,212,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,237,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,251,93,147,208,178,148,254,251,229,214,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,105,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,251,93,147,208,178,148,254,251,229,214,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,242,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,172,212,214,229,148,254,148,212,93,208,178,201,61,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,175,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,172,212,214,229,148,254,251,212,93,24,61,61,244,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,41,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,155,212,93,225,212,214,43,212,251,229,11,93,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,240,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,172,212,214,229,148,254,148,212,93,208,178,201,61,23,254,201,229,178,232,113,106,247,113,172,212,214,229,148,254,148,212,93,208,178,201,61,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,194,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,11,61,232,123,11,224,172,212,214,229,148,254,148,212,93,208,178,201,61,30,153,23,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,7,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,43,212,123,172,187,225,223,43,187,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,207,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,50,123,232,244,123,148,212,254,11,61,123,172,212,172,254,172,212,214,229,148,254,148,212,93,208,178,201,61,224,43,212,123,172,187,225,223,43,187,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,153,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,50,123,232,244,123,148,212,254,11,61,123,172,212,172,254,172,212,214,229,148,254,148,212,93,208,178,201,61,224,155,212,93,225,212,214,43,212,251,229,11,93,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,237,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,43,212,123,172,187,225,223,43,187,224,93,61,178,229,252,214,212,147,224,251,93,147,208,178,148,254,251,229,214,224,93,61,251,93,147,208,178,148,224,172,212,214,229,148,254,148,212,93,208,178,201,61,23,30,153,153,30,153,194,23,30,153,41,23,113,16,113,242,23,113,106,247,113,105,7,41,240,7,242,207,194,105,41,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,105,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,43,212,123,172,187,225,223,43,187,224,93,61,178,229,252,214,212,147,224,251,93,147,208,178,148,254,251,229,214,224,93,61,251,93,147,208,178,148,224,11,61,123,172,23,30,153,153,30,153,194,23,30,153,41,23,113,16,113,242,23,113,106,247,113,105,7,41,194,207,240,153,7,207,194,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,242,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,43,212,123,172,187,225,223,43,187,224,93,61,178,229,252,214,212,147,224,251,93,147,208,178,148,254,251,229,214,224,93,61,251,93,147,208,178,148,224,11,61,123,172,201,208,11,212,23,30,153,153,30,153,194,23,30,153,41,23,113,16,113,242,23,113,106,247,113,153,242,153,7,237,153,153,153,207,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,175,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,43,212,123,172,187,225,223,43,187,224,93,61,178,229,252,214,212,147,224,251,93,147,208,178,148,254,251,229,214,224,93,61,251,93,147,208,178,148,224,172,61,201,208,11,212,23,30,153,153,30,153,194,23,30,153,41,23,113,16,113,242,23,113,106,247,113,237,105,105,237,175,194,240,242,207,105,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,41,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,11,61,123,172,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,240,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,155,212,93,75,251,212,147,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,194,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,93,123,214,11,212,254,232,61,178,232,123,93,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,153,7,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,90,164,232,147,208,50,93,163,61,172,212,113,106,247,113,7,175,242,153,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,237,207,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,66,9,217,230,75,164,213,43,113,123,178,172,113,178,61,93,113,163,185,61,185,217,123,232,244,212,93,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,237,153,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,66,9,217,230,75,164,213,43,113,123,178,172,113,93,195,50,212,224,163,185,61,185,217,123,232,244,212,93,23,113,106,247,113,2,229,251,212,147,172,123,93,123,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,237,237,23,113,147,212,93,229,147,178,113,212,178,172,17,113,113,113,113,208,201,113,172,212,214,229,148,254,148,212,93,208,178,201,61,224,61,251,254,148,212,93,212,178,29,23,254,197,24,123,93,113,106,247,113,2,163,2,113,93,24,212,178,113,50,147,208,178,93,224,2,213,147,147,61,147,113,208,178,113,185,61,123,172,208,178,148,19,2,254,254,237,105,23,113,147,212,93,229,147,178,113,212,178,172,17,17,113,113,113,113,11,61,232,123,11,113,163,229,147,217,61,251,113,247,207,17,113,113,113,113,11,61,232,123,11,113,67,212,195,217,61,251,113,247,113,207,17,113,113,113,113,11,61,232,123,11,113,67,212,195,113,247,113,2,252,229,232,232,24,208,93,93,123,2,17,113,113,113,113,11,61,232,123,11,113,163,61,172,212,113,247,113,230,155,254,164,232,147,208,50,93,163,61,172,212,17,113,113,113,113,11,61,232,123,11,113,164,93,147,208,178,148,34,195,93,212,113,247,113,251,93,147,208,178,148,254,214,195,93,212,17,113,113,113,113,11,61,232,123,11,113,164,93,147,208,178,148,163,24,123,147,113,247,113,251,93,147,208,178,148,254,232,24,123,147,17,113,113,113,113,11,61,232,123,11,113,164,93,147,208,178,148,164,229,214,113,247,113,251,93,147,208,178,148,254,251,229,214,17,113,113,113,113,11,61,232,123,11,113,15,61,185,61,123,172,113,247,113,201,229,178,232,93,208,61,178,224,23,17,113,113,113,113,113,113,113,113,67,212,195,217,61,251,113,247,113,67,212,195,217,61,251,113,16,113,153,17,113,113,113,113,113,113,113,113,208,201,113,67,212,195,217,61,251,113,170,113,90,67,212,195,113,93,24,212,178,113,67,212,195,217,61,251,113,247,113,153,113,212,178,172,17,113,113,113,113,113,113,113,113,163,229,147,217,61,251,113,247,113,163,229,147,217,61,251,113,16,113,153,17,113,113,113,113,113,113,113,113,208,201,113,163,229,147,217,61,251,113,170,113,90,163,61,172,212,113,93,24,212,178,17,113,113,113,113,113,113,113,113,113,113,113,113,147,212,93,229,147,178,113,2,2,17,113,113,113,113,113,113,113,113,212,11,251,212,17,113,113,113,113,113,113,113,113,113,113,113,113,11,61,232,123,11,113,4,212,197,34,195,93,212,113,247,113,164,93,147,208,178,148,34,195,93,212,224,164,93,147,208,178,148,164,229,214,224,163,61,172,212,30,163,229,147,217,61,251,30,163,229,147,217,61,251,23,23,113,39,113,164,93,147,208,178,148,34,195,93,212,224,164,93,147,208,178,148,164,229,214,224,67,212,195,30,67,212,195,217,61,251,30,67,212,195,217,61,251,23,23,17,113,113,113,113,113,113,113,113,113,113,113,113,208,201,113,4,212,197,34,195,93,212,113,150,113,207,113,93,24,212,178,113,4,212,197,34,195,93,212,113,247,113,4,212,197,34,195,93,212,113,16,113,237,175,41,113,212,178,172,17,113,113,113,113,113,113,113,113,113,113,113,113,147,212,93,229,147,178,113,164,93,147,208,178,148,163,24,123,147,224,4,212,197,34,195,93,212,23,17,113,113,113,113,113,113,113,113,212,178,172,17,113,113,113,113,212,178,172,17,113,113,113,113,11,61,232,123,11,113,230,213,4,66,113,247,113,230,155,254,164,232,147,208,50,93,213,4,66,113,61,147,113,167,230,155,113,247,113,230,155,48,17,113,113,113,113,11,61,123,172,224,15,61,185,61,123,172,30,178,208,11,30,2,214,93,2,30,230,213,4,66,23,224,23,17,113,113,113,113,15,61,185,61,123,172,113,247,113,201,229,178,232,93,208,61,178,224,23,113,212,178,172,17,156,166,247,171,236,173,30,176,16,6,250,216,100,211,35,123,253,87,191,210,237,73,230,225,47,7,197,27,117,169,251,177,145,145,103,62,125,125,147,191,56,198,223,10,125,181,242,61,17,205,156,210,93,152,194,101,126,90,117,232,111,162,206,136,9,62,197,47,23,38,95,46,216,72,120,129,127,109,92,38,9,16,89,230,118,66,74,170,105,248,192,50,236,242,32,63,238,141,251,96,171,27,147,169,247,11,133,131,58,45,145,178,188,17,175,109,57,60,143,72,92,40,17,215,156,95,53,166,230,59,207,127,92,2,81,160,21,93,248,138,177,244,3,140,186,7,40,184,170,147,77,201,12,31,238,97,236,226,228,132,159,65,179,121,184,189,15,66,207,169,177,127,108,218,222,116,139,109,124,187,110,201,122,159,52,183,175,151,118,108,114,38,45,130,40,35,121,9,141,39,132,38,116,58,71,145,182,84,92,140,220,222,201,90,30,25,233,199,128,225,63,104,17,30,40,38,201,132,106,209,234,53,129,167,254,115,144,139,209,204,130,196,194,20,37,5,111,113,103,134,125,145,175,81,1,255})
--