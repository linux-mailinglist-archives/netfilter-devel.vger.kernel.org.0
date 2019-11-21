Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5110580F
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKURKP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 12:10:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27015 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726568AbfKURKP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574356214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v/Uv3Adi5yWmJRAXn1f1y0ZIeuKV7Bvm9yBNTloa79Q=;
        b=DbD8NEICyyVZcK8lESb5EHFO7Zpssmqijcy98Pgj+l+tcewQLDR0iRwIutlm7DTQbgltfK
        c5NW0YWtrZhLXE/+eg7HA3I4anSQoV4x8ddpxENK9p5bmM81qC5GLK59MUEDQmAN7zWYpd
        ZtmFABuNUNzKAPnm+KxoWmfPSE6COro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-0JMcVa4JMGemHg67ww0G1Q-1; Thu, 21 Nov 2019 12:10:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66916802689;
        Thu, 21 Nov 2019 17:10:10 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBDFA6E3F9;
        Thu, 21 Nov 2019 17:10:07 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nft v2 0/3] Introduce support for concatenated ranges
Date:   Thu, 21 Nov 2019 18:10:03 +0100
Message-Id: <cover.1574353687.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0JMcVa4JMGemHg67ww0G1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is the counterpart of kernel series:
  nftables: Set implementation for arbitrary concatenation of ranges

and it has a UAPI dependency on kernel patch:
  [PATCH nf-next 1/8] nf_tables: Support for subkeys, set with multiple ran=
ged fields

Patch 1/3 adds support for NFT_SET_SUBKEY: these new netlink
attributes specify the length of fields within concatenations,
and they are needed by set implementations in the kernel to
figure out where single fields start and stop.

Patch 2/3 introduces new key data semantics needed to represent
arbitrary concatenation of ranges with minimal UAPI modifications,
as well as required changes in lexer and expression evaluation.

Patch 3/3 adds test cases for operations on the new set type.

I'm not updating the UAPI header copy in this series, please
let me know if I'd better do that.

v2: changes listed in messages for 2/3 and 3/3

Stefano Brivio (3):
  src: Add support for and export NFT_SET_SUBKEY attributes
  src: Add support for concatenated set ranges
  tests: Introduce test for set with concatenated ranges

 include/expression.h                          |   2 +
 include/rule.h                                |   7 +
 src/evaluate.c                                |  25 ++-
 src/mnl.c                                     |   4 +
 src/netlink.c                                 |  99 ++++++++---
 src/parser_bison.y                            |  89 ++++------
 src/rule.c                                    |  10 +-
 src/segtree.c                                 | 117 +++++++++++++
 .../testcases/sets/0041concatenated_ranges_0  | 162 ++++++++++++++++++
 9 files changed, 417 insertions(+), 98 deletions(-)
 create mode 100755 tests/shell/testcases/sets/0041concatenated_ranges_0

--=20
2.20.1

