Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AA8E881
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Aug 2019 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfHOJqN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Aug 2019 05:46:13 -0400
Received: from vxsys-smtpclusterma-03.srv.cat ([46.16.60.199]:57833 "EHLO
        vxsys-smtpclusterma-03.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbfHOJqN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:46:13 -0400
Received: from [192.168.0.22] (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-03.srv.cat (Postfix) with ESMTPSA id 5A86F24265;
        Thu, 15 Aug 2019 11:46:06 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] netfilter: Introduce new 64-bit helper functions
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20190813183820.6659-1-a@juaristi.eus>
 <20190813185852.vzt4zjrditmptvmp@salvia>
From:   Ander Juaristi <a@juaristi.eus>
Message-ID: <052bfb99-22c1-749f-464d-ab63ad8d0e4c@juaristi.eus>
Date:   Thu, 15 Aug 2019 11:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813185852.vzt4zjrditmptvmp@salvia>
Content-Type: multipart/mixed;
 boundary="------------C3DA80DD40E2BAAB11AE1A75"
Content-Language: en-US
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C3DA80DD40E2BAAB11AE1A75
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/8/19 20:58, Pablo Neira Ayuso wrote:
> On Tue, Aug 13, 2019 at 08:38:19PM +0200, Ander Juaristi wrote:
> [...]
>> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter=
/nf_tables.h
>> index 9b624566b82d..aa33ada8728a 100644
>> --- a/include/net/netfilter/nf_tables.h
>> +++ b/include/net/netfilter/nf_tables.h
>> @@ -2,6 +2,7 @@
>>  #ifndef _NET_NF_TABLES_H
>>  #define _NET_NF_TABLES_H
>> =20
>> +#include <asm/unaligned.h>
>>  #include <linux/list.h>
>>  #include <linux/netfilter.h>
>>  #include <linux/netfilter/nfnetlink.h>
>> @@ -119,6 +120,16 @@ static inline void nft_reg_store8(u32 *dreg, u8 v=
al)
>>  	*(u8 *)dreg =3D val;
>>  }
>> =20
>> +static inline void nft_reg_store64(u32 *dreg, u64 val)
>> +{
>> +	put_unaligned(val, (u64 *)dreg);
>> +}
>> +
>> +static inline u64 nft_reg_load64(u32 *sreg)
>> +{
>> +	return get_unaligned((u64 *)sreg);
>> +}
>=20
> Please, add these function definition below _load16() and _store16().

You mean you'd like them ordered from smaller to larger?

nft_reg_store8
nft_reg_load8
nft_reg_store16
nft_reg_load16
nft_reg_store64
nft_reg_load64

>> +
>>  static inline u16 nft_reg_load16(u32 *sreg)
>>  {
>>  	return *(u16 *)sreg;
>> diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteord=
er.c
>> index e06318428ea0..a25a222d94c8 100644
>> --- a/net/netfilter/nft_byteorder.c
>> +++ b/net/netfilter/nft_byteorder.c
>> @@ -43,14 +43,14 @@ void nft_byteorder_eval(const struct nft_expr *exp=
r,
>>  		switch (priv->op) {
>>  		case NFT_BYTEORDER_NTOH:
>=20
> This is network-to-host byteorder.
>=20
>>  			for (i =3D 0; i < priv->len / 8; i++) {
>> -				src64 =3D get_unaligned((u64 *)&src[i]);
>> -				put_unaligned_be64(src64, &dst[i]);
>> +				src64 =3D nft_reg_load64(&src[i]);
>> +				nft_reg_store64(&dst[i], cpu_to_be64(src64));
>=20
> This looks inverted, this should be:
>=20
> 				nft_reg_store64(&dst[i], be64_to_cpu(src64));
>=20
> right?
>=20
>>  			}
>>  			break;
>>  		case NFT_BYTEORDER_HTON:
>=20
> Here, network-to-host byteorder:
>=20
>>  			for (i =3D 0; i < priv->len / 8; i++) {
>> -				src64 =3D get_unaligned_be64(&src[i]);
>> -				put_unaligned(src64, (u64 *)&dst[i]);
>> +				src64 =3D be64_to_cpu(nft_reg_load64(&src[i]));
>=20
> and this:
>=20
>                                 src64 =3D (__force __u64)
>                                         cpu_to_be64(nft_reg_load64(&src=
[i]));
>=20

My bad. Yes, I've just fixed them.

> The (__force __u64) just makes 'sparse' happy [1].
>=20
> [1] https://www.kernel.org/doc/html/v4.12/dev-tools/sparse.html
>=20

--------------C3DA80DD40E2BAAB11AE1A75
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQMuBFiPEUsRCAC5+qFooGMhKHGsdSrjdGe6ivGDJOBLAMJDaOV5hHo1KImG9k18
b6mDNu3LQmtxrjKUWCpMsUVyPwZtdGxCGCJCnVUgLYuiMgm3WcaI+Aluhz8ACKeC
fbYUEZSo7AT9zKaLMHuPQd19eWLg7co1w+otbZ+/cOdI1bd2NHABCnon9LC+TtUx
p2Gdtqo5PtepGVQSnlu0b70qHvZn5986yfGQpHAibh/oF8lmq94HQRVJCSLHVxm4
6POIS1tLEeIZ8gXY7JyxlROt/alXlRmPCrBnw9r/fTmFRXWutV1oYbBdU8ZMNoP0
z/T9oat+SehcNPfHbC3oxYHXnDcTUBfDf7o/AQD+CGiyZF7/dlb1R8E7N8RPJcIC
JltEdkBIupnX7go+aQf9E2fkvdulNnUCzpw+6FMztZuGMFoj5GkwJ4DyiFYrnJvu
K+99sQlAHb8/38J2HbnbOvWp0oN0JGq19K8WYMhCMf0m9ZmsLL1pREA9fu++FM0N
Nd5kEx5ZMCorV1yqjqa20+OJzWXexWP+E4e2lLQX/MwVF8l7AKi1gYL8sqntAcVA
aPqfEvIUvhVU4J1urG07b/qP65yTL7lt3fqHleFfP2rro0WW3TqNPFLqo8F40POd
lAw3Rr+gqtUFYQmVvWkwPUuvIfigbQVEv7Yslg/nT59hbym/7xvDNmC+lxcSqS5V
B6IGg3Z8oCK/BDNmaDL6Z55ZECtP0VXDZxoOAJKbMwgAtErcBOVhwvRXEMjk1E0/
dcqmyMKl3CwXWb5BzxBeGPDVS3c5mQkZlDNH+g1KSkklcuGHNMDcJdKdEHU+nd7u
IvCYKB9NMcI7IRgTF8kuBpRTM5biwdYhW52+MNJUu52xrlfU0Ow51Gw3qqPV7Gno
XsFRVFbW50U/6W2iLr8kZPoU0IYkgq9pAS4NU9G+4dhuWQGRGGHjr51frS2fqXU+
URkRy61NtVch07fQqP2ytBTd5PxQDkoUgJWSTHUM10AvXKb8yjSUGDvhgSbr6J3y
WU1JkSmFnI8SIav+MNOLYY48neg+ldI50JVRr9fpNyvRYp9BQ3rX0uq0ZGESFP6M
BLQfQW5kZXIgSnVhcmlzdGkgPGFAanVhcmlzdGkuZXVzPoiXBBMRCAA/AhsDBgsJ
CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBKWGNa7OKIB+2X91OK3Mlkc8+beCBQJc
cpfKBQkFxJtlAAoJEK3Mlkc8+beC/rEBAO3T4i4SPQReDUXJpd/0wNxBVof4VR9y
pMUKTtq0ltd0AQDfR6EGufQr3Vo7vAFPRCpV0hEMyQsiAmxONP7uoZCkoYkCMwQQ
AQoAHRYhBD6J7udFjnINl1Tgsl4oozsLhPV3BQJZvB+eAAoJEF4oozsLhPV3VcUP
/RLFfJTimvzrjvj84Sm1yi1IjM9AX43zKfNC0l1T041+75IwJA7/PeSBHo4fwXJ+
y1FDcyIgN3B7mCTSvRCKrx01Ax5TeV9jHZ+f38kGDGzfuO25xzMTdJsxb2N43hNy
5ikarUDPdzbcetqJZh9ZolmIRIHkpx0ihqfjJVo1ABW7Ksb/mVyU+0r1cd/slOLP
blSqyTYFezIWnlYAxUjjw6rEfuy4lQntlc6CyYL3tk31snFoIGDGTpeQj/irk3Kw
Fon8uQHLtiMCzuMzBftPR7QF7HPGiVc1n+oPJuufN9EjImAbIWuFBUUSiybq88ta
g5myZNPOkjM1sKJ6Qd+xR4w4A1aueQO3O/DSG9MwSxUAXBejyXSWrUNVnDXt2Vsg
OFQ7mnXmXGeubhEJu1FWjV+tV2SiWWHZuT3NapObxK/hueAPxiSZ1orM+Og4rYmP
CAZS2KpkB6LKMvauRR/9y+uZ1SRJYYDp89aFqFFbJ3jxvxBG0rctSQfyOFemuAsj
l/sS7w8+X9FHoVzKNTXmPeQ6oalh3slo/SGMY1Niccs2Gdy/yZ/vlt7/B5txvsLi
jhTQq3XOKmIKHc3/dxeLlp4WudjAGtEMizJ7FT1j0+laXI7g8WjWuwDqIvjrveZ2
RRyK4Pao5Q8/OzSD3ZuXW2RMbMr0l19WnvkBzkXWai7+iQIzBBABCgAdFiEEeEUS
CwfL2Nbs5f8rKhdD7akaNbYFAlmlPW4ACgkQKhdD7akaNbbiKxAApMS/38nN9/8R
e9Ea+MeQFm4kjHdfa0coyXzzjsiLberFOL/zWlXbzm997UjGqJl65zJuVQybaf/a
UyX4cv2M1vTITlk3Ty6DrCUwQGcwPz3f+36Edp/Qcy6R7Ww9AM6nbkhcSTYfIj3v
emvTnHGZCmUT5ZxqbUE2WAaFJ/ExGhz+8VEBYQccen5UlLiGXVicpRMU1VyY9aMi
LnD3SVju7Osl9wjWw9JIPtzPLktYengjt97IEqMsn+8pXgjr3AFWnf8iCWbUasOP
vg+a6V9lRSRt9zQZXV8EahfzgjrIud57umvvkTvfgDNFYvCr7ZpNGXlz6brRWNux
oQH+yZZzg0cbzlBACB+meCbSyloDYrCdpAJV2hOOPxuR4pzEkWzfg/IoEVatpc1D
cEImovnzR3ts7Zk3ZfFH0YtrI8zENcXGyKNfLZqEXAiQXXD3kGwRGGapTv3IDIV6
pYCdPKsbR3WWRy5hg6pXPprnaxjSpo3028zwD4vxvVb2rg8uYwwCMeLgh4Zidpqo
h663U7wEIGfgrD5KesXkIZhskGvi/QnJhsjAP2FVgGKOiqVkQpz0GQXJ0IRMhWCb
rRF+YIbYLxG3dqt1WEuhOBNjS0qtxa5ZPlRkX9GvMF9HfRJB8voOe+VO8NdoPgJ/
2XhV6SDri7wQFLGwN7NGy7ZPMfi8wCuJAjMEEwEIAB0WIQQ85GRVioT9xp20DPsJ
CxGZPZrrtQUCWaWb8gAKCRAJCxGZPZrrtc04D/9PGtQPuDW0U7CJSOmkDD78Xobm
7Rwr4ve3aX0G8EZcaghCHucI29JM4INEW1z0peXeaxO7MTdZqAonoGOVPpew8wHj
ELY3e0fGxWtEF0dMJc68nrCou+KAr5zW76OkrS/NK1TwbceN/YoomWZC4HoiaMuY
Lq9W8fBRrsa5KNnn3WsQLqDTN+3UumSv1MQzm2074svvWEtixebGObFX37VBJWQs
ZVASbBTxxqbIed7SJofIIrRqcFRiGB+rC7Dzto9TgMhCIVvLds4SgCt1xQmv32E4
pmC1x+tXG40WX3Euz18ZxZlQCMcJXZ3RyscDI3TTxpVa8mBIyEru2/mxfJXOBfAq
qJ1SLgvVMrsfmADT4fdqT5RhHABQfYNqBvCHJCnHw9xSLWyXxYfErh3hs2gXVtvW
8oxscPt6O3WCkW1b+CewO3Or9SH3+NNSK6B/UkMcd1ABahLLvf+U4OnOTrsYoQlX
GHA9WLKE0Kf0cZkFnUt0HTRdgwaYTI7rbRoIK9APt5rzdCaRbIHaZ0hKwly65XQ1
18c11dpArVOFVx1PhFQyuEwBFpVFJi9IkuexhAAAb4f2/fco44rockyL7zOCGDYi
6Xkon1IQ5MxOGaxrn/8NFN4y/IXGDz5DkbHxJBua50rWecq008iS6aDbYR3T+ati
TimpwU2KVrdNdsNgGokCMwQTAQoAHRYhBByyfbyYYUstWEFkbQgwLbaiZwQoBQJZ
pot7AAoJEAgwLbaiZwQovLEP/1/oa8tmJC5a0xTcqOmNfF6xmHch6me5+kUgYjd4
dxo8pIYfRe3dN3WQkwUs1pScXwcNH/qpg6aSPO42BA6Vd7n7xvEO8Oj5VZm20g8Q
0rr1ql8mmCBNmLcp5rEF9e7BY+A0ZXncYNEwpipMu5gidSLRdLMnUCHlpOtj43E0
3k0goMwCeYVIuQN6ckiRWP7X4ha4RtNJL/AiGFRrLHAEIk2O7sq70uaQGTlPjIvk
mHTR/HG/KLmXA42w7kB3ZCO2m1rk0vxcca4xkhvwuKZLiMlkgeGEmDOJwKK9hvvt
YNwZp4pECv7THBLtY/h5RUisruiCjFIe/cTKS5AzsD+ULaz+6ImOZcTe7Yrnsfai
NNotzyZC0+mW9Bvix4sxMsDYxo8NCKW+5FgmoH0ou5TOnM2Zs8GX6kID6SJxS4jt
iyFVno3Bkld9qpFfEhB67I++U/w2/JKZ7CQ5sWFHwUjy6EhV3XE6FxGH9V8zye9g
uHcjuyavLpi8+7MEBQ08AAKcwUoWpiRGo4vThflutER3XvozDNSCVuG+OBL8V3zs
etzTqCsFuoCEgJaINFUWV6zSQjcebDvj1RS+0WuP7knNNY8oo+2gXrK6GFATUvFo
3RdrSPq+HqhWMdmtkQ0rs+sdRyjO4c80SqB76CD2d5RSEJU91mj+OjhxjNCjDy2D
T94ZiIAEExEIACgFAliPEUsCGwMFCQHhM4AGCwkIBwMCBhUIAgkKCwQWAgMBAh4B
AheAAAoJEK3Mlkc8+beC844A/06kZ6xYMbHaCkDNYobAJuHTTsXg6liLE4ukgscw
Z9hAAQCGxLh4ZOR6BYRKS+3HN/QRpJK87lp5al6+fuGwLqUDx4kBMwQTAQgAHRYh
BLymibY2VTgBw8YhUBl6WIgjX6ysBQJZxXYfAAoJEBl6WIgjX6ysrxcIAKWKysIy
BnvqWeQMdRCCQ2WxXCQxx5OccpZYxLmKEHrmt9HiSm4ajffG5MVjBau2hptOWMMP
qCccUKly4w3TIfdXV7Q58zpcrnlWpWLBRnqweEMsZ8DJJJ9Bx5Zk0+XcDrZBp+kQ
MZgv3gYWrDP2hjYgg3IWSbOAyvUxgXYnwhPzvm93icTUDBAW9iKlhAJEGyPc2iVv
ED0Td9nxT2i4beB8HqyrAjbKuLKao38vUQqOi+s6qgNXeRJLggudDo541snLwcDR
kV65HNGnAuPWPIIsj4xMRtCa8mufneXMOKZAozVT5tmJvxH3CiQAvvgyvw2E+6NY
ZaeErOehfv6LlkGIgAQTEQgAKAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AF
AlqOi+4FCQPgriMACgkQrcyWRzz5t4LfqQEAiVnQfUtUFlnd6kcin3AkEY6Q3Mke
BlzWevYS1OrSz1oBANjBZWskg/AM+CNjOAUERP7xgaAlRWX6RlUueDYlCsgVuQIN
BFiPEUsQCAD/2/Osdk3nus0SuCgkptQu4drizx8Ujy+1D+rDUS+7mvv9XSGrKm10
OL963mYL1cusbFwLZhE+3OKoeKhwl6j1Kair1NhMsjQGx4qoeMUUZkyocpeD3cbE
5+LozQoL832rvCE+4KQnysLOAkklwR0Yd5Slqtol9KJSEFNk8TV8J3mdzOdmXC1t
OzxbZXxc6iqaFbz6PNOKe1Xj03YBZKFWGeXI0eCBKw8UTQhzi6u/hTzSTegkebih
8+MZrMoz+7Aq+ZhRuhEvI/ltrnXyj98CVtmy5UWRb7nVqvdLZnJb5RxDt9STVZRB
AJTTLVttsMVc1oY9NbUFKQjbnbc+6K+PAAMFB/9rCdYy4J1I0MEfs4j7eM74LqZ0
utp0HKvGslz0MyVvYGbqgaQvCj4ztr5LRsUWSvAELoaxoykS9s1UflMSLAyM5Ds2
Eme+R45Wua3nUpvVch956/+GM4FeJRncgp+Q9JVja77C8mMjuil42e78WZqcbqPG
16Nb57JcWPF8nHaJZHJCAgkQiMInIWmFAONYrYWtUGViPwQibCc46ZNHez6hMHmm
5RVAylpVKo4nro+5ft8652D3zXAmfoclcmaZl0hR2DC1ng70+YoCEzX5H+bJxhtH
R7bTOv1N5McE/GofPOMDSdQhZLPEINWPEtJ7IsX0EiQdaD4BmthAZEvIGIVIiH4E
GBEIACYCGwwWIQSlhjWuziiAftl/dTitzJZHPPm3ggUCXHKX0wUJBcSbZQAKCRCt
zJZHPPm3grZOAP9yy321xYqTb5aNU5vvhNZR71g+2jFsYd/s+1UDS2kIUgEA1o8e
uJnKmDCTU3EjmLMmBF1HhrAqfWklCjZHAl4LdXY=3D
=3DXX5J
-----END PGP PUBLIC KEY BLOCK-----

--------------C3DA80DD40E2BAAB11AE1A75--
