Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9886295347
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Oct 2020 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392080AbgJUUKs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Oct 2020 16:10:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbgJUUKr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:10:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LK2Fog075200;
        Wed, 21 Oct 2020 20:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=bLzoDnLu6uxWewqIPOexofRL1trQK7hpq2N0XtryxEQ=;
 b=eblZMsPaoVSwAHgZy/EG486s+EUxBeEwi+n6XcorREqZKlHhGDf+8qsoedejEEDGnlHi
 KgvxkVEfPbRuMm8guCOqqEY32VapD9JHvYlDPHWuWh2emguDVIz06C+BNJFWeZtADoGH
 mrzTKChLrDhA/pNgc+4VL2+f4GF4T1bAkQVo/gJ8/DgE7Pz0Iq2L6ORihN+D6+kvubWe
 2gKjp1o5bV4o3cdrs/Pdy3Qhp9pYqAeG+60SCYVhGdEvK8caw3Uhu0LBelehQ5TIiaix
 n/lfvw4y4N3m9GQZrtJgKs4gkOVxBzx+tsLS5Wvvi/7gJpkbRlxU4Zxxv8gDuJ84tr5g tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34ak16jxfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 20:10:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09LJxwq2083190;
        Wed, 21 Oct 2020 20:08:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ak1932cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Oct 2020 20:08:30 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09LK8QU5001401;
        Wed, 21 Oct 2020 20:08:26 GMT
Received: from dhcp-10-159-133-119.vpn.oracle.com (/10.159.133.119)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Oct 2020 13:08:26 -0700
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Message-Id: <3BE1A64B-7104-4220-BAD1-870338A33B15@oracle.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_85EEF967-1E9A-4C74-A0CD-34594BFC22E6"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH linux-5.9 1/1] net: netfilter: fix KASAN:
 slab-out-of-bounds Read in nft_flow_rule_create
Date:   Wed, 21 Oct 2020 13:08:24 -0700
In-Reply-To: <28C74722-8F35-4397-B567-FA5BCF525891@oracle.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, kuba@kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
References: <20201019172532.3906-1-saeed.mirzamohammadi@oracle.com>
 <20201020115047.GA15628@salvia>
 <28C74722-8F35-4397-B567-FA5BCF525891@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010210140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010210140
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--Apple-Mail=_85EEF967-1E9A-4C74-A0CD-34594BFC22E6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Attached the syzkaller C repro.

Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>

--Apple-Mail=_85EEF967-1E9A-4C74-A0CD-34594BFC22E6
Content-Disposition: attachment;
	filename=repro.c
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="repro.c"
Content-Transfer-Encoding: 7bit

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len) *(type*)(addr) =htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | (((type)(val)<< (bf_off)) & BITMASK((bf_off), (bf_len))))

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

int main(void)
{
        syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
    syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
                intptr_t res = 0;
    res = syscall(__NR_socket, 0x10ul, 3ul, 0xc);
    if (res != -1)
        r[0] = res;
*(uint64_t*)0x20000240 = 0;
*(uint32_t*)0x20000248 = 0;
*(uint64_t*)0x20000250 = 0x20000100;
*(uint64_t*)0x20000100 = 0x20000280;
*(uint32_t*)0x20000280 = 0x14;
*(uint16_t*)0x20000284 = 0x10;
*(uint16_t*)0x20000286 = 1;
*(uint32_t*)0x20000288 = 0;
*(uint32_t*)0x2000028c = 0;
*(uint8_t*)0x20000290 = 0;
*(uint8_t*)0x20000291 = 0;
*(uint16_t*)0x20000292 = htobe16(0xa);
*(uint32_t*)0x20000294 = 0x14;
*(uint8_t*)0x20000298 = 2;
*(uint8_t*)0x20000299 = 0xa;
*(uint16_t*)0x2000029a = 0x401;
*(uint32_t*)0x2000029c = 0;
*(uint32_t*)0x200002a0 = 0;
*(uint8_t*)0x200002a4 = 0;
*(uint8_t*)0x200002a5 = 0;
*(uint16_t*)0x200002a6 = htobe16(0);
*(uint32_t*)0x200002a8 = 0x20;
*(uint8_t*)0x200002ac = 0;
*(uint8_t*)0x200002ad = 0xa;
*(uint16_t*)0x200002ae = 0x401;
*(uint32_t*)0x200002b0 = 0;
*(uint32_t*)0x200002b4 = 0;
*(uint8_t*)0x200002b8 = 1;
*(uint8_t*)0x200002b9 = 0;
*(uint16_t*)0x200002ba = htobe16(0);
*(uint16_t*)0x200002bc = 9;
*(uint16_t*)0x200002be = 1;
memcpy((void*)0x200002c0, "syz0\000", 5);
*(uint32_t*)0x200002c8 = 0x48;
*(uint8_t*)0x200002cc = 3;
*(uint8_t*)0x200002cd = 0xa;
*(uint16_t*)0x200002ce = 0x201;
*(uint32_t*)0x200002d0 = 0;
*(uint32_t*)0x200002d4 = 0;
*(uint8_t*)0x200002d8 = 1;
*(uint8_t*)0x200002d9 = 0;
*(uint16_t*)0x200002da = htobe16(0);
*(uint16_t*)0x200002dc = 9;
*(uint16_t*)0x200002de = 3;
memcpy((void*)0x200002e0, "syz0\000", 5);
*(uint16_t*)0x200002e8 = 9;
*(uint16_t*)0x200002ea = 1;
memcpy((void*)0x200002ec, "syz0\000", 5);
*(uint16_t*)0x200002f4 = 8;
STORE_BY_BITMASK(uint16_t, , 0x200002f6, 0xa, 0, 14);
STORE_BY_BITMASK(uint16_t, , 0x200002f7, 1, 6, 1);
STORE_BY_BITMASK(uint16_t, , 0x200002f7, 0, 7, 1);
*(uint32_t*)0x200002f8 = htobe32(2);
*(uint16_t*)0x200002fc = 0x14;
STORE_BY_BITMASK(uint16_t, , 0x200002fe, 4, 0, 14);
STORE_BY_BITMASK(uint16_t, , 0x200002ff, 0, 6, 1);
STORE_BY_BITMASK(uint16_t, , 0x200002ff, 1, 7, 1);
*(uint16_t*)0x20000300 = 8;
STORE_BY_BITMASK(uint16_t, , 0x20000302, 2, 0, 14);
STORE_BY_BITMASK(uint16_t, , 0x20000303, 1, 6, 1);
STORE_BY_BITMASK(uint16_t, , 0x20000303, 0, 7, 1);
*(uint32_t*)0x20000304 = htobe32(2);
*(uint16_t*)0x20000308 = 8;
STORE_BY_BITMASK(uint16_t, , 0x2000030a, 1, 0, 14);
STORE_BY_BITMASK(uint16_t, , 0x2000030b, 1, 6, 1);
STORE_BY_BITMASK(uint16_t, , 0x2000030b, 0, 7, 1);
*(uint32_t*)0x2000030c = htobe32(0);
*(uint32_t*)0x20000310 = 0x14;
*(uint16_t*)0x20000314 = 0x11;
*(uint16_t*)0x20000316 = 1;
*(uint32_t*)0x20000318 = 0;
*(uint32_t*)0x2000031c = 0;
*(uint8_t*)0x20000320 = 0;
*(uint8_t*)0x20000321 = 0;
*(uint16_t*)0x20000322 = htobe16(0xa);
*(uint64_t*)0x20000108 = 0xa4;
*(uint64_t*)0x20000258 = 1;
*(uint64_t*)0x20000260 = 0;
*(uint64_t*)0x20000268 = 0;
*(uint32_t*)0x20000270 = 0;
    syscall(__NR_sendmsg, r[0], 0x20000240ul, 0ul);
    res = syscall(__NR_socket, 0x10ul, 3ul, 0xc);
    if (res != -1)
        r[1] = res;
*(uint64_t*)0x200000c0 = 0;
*(uint32_t*)0x200000c8 = 0;
*(uint64_t*)0x200000d0 = 0x20000080;
*(uint64_t*)0x20000080 = 0x20000500;
*(uint32_t*)0x20000500 = 0x14;
*(uint16_t*)0x20000504 = 0x10;
*(uint16_t*)0x20000506 = 1;
*(uint32_t*)0x20000508 = 0;
*(uint32_t*)0x2000050c = 0;
*(uint8_t*)0x20000510 = 0;
*(uint8_t*)0x20000511 = 0;
*(uint16_t*)0x20000512 = htobe16(0xa);
*(uint32_t*)0x20000514 = 0x2c;
*(uint8_t*)0x20000518 = 6;
*(uint8_t*)0x20000519 = 0xa;
*(uint16_t*)0x2000051a = 0x401;
*(uint32_t*)0x2000051c = 0;
*(uint32_t*)0x20000520 = 0;
*(uint8_t*)0x20000524 = 1;
*(uint8_t*)0x20000525 = 0;
*(uint16_t*)0x20000526 = htobe16(0);
*(uint16_t*)0x20000528 = 9;
*(uint16_t*)0x2000052a = 1;
memcpy((void*)0x2000052c, "syz0\000", 5);
*(uint16_t*)0x20000534 = 9;
*(uint16_t*)0x20000536 = 2;
memcpy((void*)0x20000538, "syz0\000", 5);
*(uint32_t*)0x20000540 = 0x14;
*(uint16_t*)0x20000544 = 0x11;
*(uint16_t*)0x20000546 = 1;
*(uint32_t*)0x20000548 = 0;
*(uint32_t*)0x2000054c = 0;
*(uint8_t*)0x20000550 = 0;
*(uint8_t*)0x20000551 = 0;
*(uint16_t*)0x20000552 = htobe16(0xa);
*(uint64_t*)0x20000088 = 0x54;
*(uint64_t*)0x200000d8 = 1;
*(uint64_t*)0x200000e0 = 0;
*(uint64_t*)0x200000e8 = 0;
*(uint32_t*)0x200000f0 = 0;
    syscall(__NR_sendmsg, r[1], 0x200000c0ul, 0ul);
    return 0;
}


--Apple-Mail=_85EEF967-1E9A-4C74-A0CD-34594BFC22E6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 20, 2020, at 9:45 AM, Saeed Mirzamohammadi =
<saeed.mirzamohammadi@oracle.com> wrote:
>=20
> Thanks! Yes, that looks good to me.
>=20
> Saeed
>=20
>> On Oct 20, 2020, at 4:50 AM, Pablo Neira Ayuso <pablo@netfilter.org> =
wrote:
>>=20
>> On Mon, Oct 19, 2020 at 10:25:32AM -0700, =
saeed.mirzamohammadi@oracle.com wrote:
>>> From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>>>=20
>>> This patch fixes the issue due to:
>>>=20
>>> BUG: KASAN: slab-out-of-bounds in nft_flow_rule_create+0x622/0x6a2
>>> net/netfilter/nf_tables_offload.c:40
>>> Read of size 8 at addr ffff888103910b58 by task =
syz-executor227/16244
>>>=20
>>> The error happens when expr->ops is accessed early on before =
performing the boundary check and after nft_expr_next() moves the expr =
to go out-of-bounds.
>>>=20
>>> This patch checks the boundary condition before expr->ops that fixes =
the slab-out-of-bounds Read issue.
>>=20
>> Thanks. I made a slight variant of your patch.
>>=20
>> I'm attaching it, it is also fixing the problem but it introduced
>> nft_expr_more() and use it everywhere.
>>=20
>> Let me know if this looks fine to you.
>> <0001-netfilter-fix-KASAN-slab-out-of-bounds-Read-in-nft_f.patch>
>=20


--Apple-Mail=_85EEF967-1E9A-4C74-A0CD-34594BFC22E6--
