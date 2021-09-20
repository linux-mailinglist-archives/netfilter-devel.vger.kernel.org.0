Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB3410E15
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Sep 2021 03:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhITBBZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Sep 2021 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhITBBZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Sep 2021 21:01:25 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010BC061574
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Sep 2021 17:59:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1C5E1806A8;
        Mon, 20 Sep 2021 12:59:56 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1632099596;
        bh=BhG7em53VFWZ/Wx85a/O793AuDwAlThhM1LjxqJgOiE=;
        h=From:To:Cc:Subject:Date;
        b=CWSh0nd9D+iu3IED62vvownqczmy4sOk+I1/8JdiyA3vYDfBgDy/JUPSEckBqmIqL
         fDxpbAg6LEGBfD0NV1hQo8v3asCg9wAvBz2UXQ0l7WAQRhtWHs/dS9Vb9s03JMz43E
         p4oFpyCsU+K/fKfL3BD+dociiwfrNhX1pkjv96c1xGmIuLKiOPtt1q+2qNuHsk4T4s
         pBFNP94D9ob43RnLLRyOv0U3UJrmT1cbmK9nQ83EAd/m4n8YmKOYPotnMLL1fsndT9
         fwzA0qQNKfnRbuQjP+RU11KRNpG2AXX1ILr4xo+f4jl3pByv9eEmpuchNOveeNqoVh
         VntRXN+XOlkYw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6147dd160000>; Mon, 20 Sep 2021 13:00:06 +1200
Received: from coled-dl.ws.atlnz.lc (coled-dl.ws.atlnz.lc [10.33.25.26])
        by pat.atlnz.lc (Postfix) with ESMTP id DF18513EE58;
        Mon, 20 Sep 2021 12:59:55 +1200 (NZST)
Received: by coled-dl.ws.atlnz.lc (Postfix, from userid 1801)
        id D91A524285E; Mon, 20 Sep 2021 12:59:55 +1200 (NZST)
From:   Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        Cole Dishington <Cole.Dishington@alliedtelesis.co.nz>
Subject: [PATCH net v5 0/2] Fix port selection of FTP for NF_NAT_RANGE_PROTO_SPECIFIED
Date:   Mon, 20 Sep 2021 12:59:03 +1200
Message-Id: <20210920005905.9583-1-Cole.Dishington@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=FtN7AFjq c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=7QKq2e-ADPsA:10 a=DMskShvhW02lbXicVFgA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thanks for your time reviewing!

Changes:
Divide changes into two patches
- Limit the number of ports checked by ftp helper to 128.
- Fix port selection of FTP for NF_NAT_RANGE_PROTO_SPECIFIED.

Cole Dishington (2):
  net: netfilter: Limit the number of ftp helper port attempts
  net: netfilter: Fix port selection of FTP for
    NF_NAT_RANGE_PROTO_SPECIFIED

 include/net/netfilter/nf_nat.h |  6 ++++
 net/netfilter/nf_nat_core.c    |  9 ++++++
 net/netfilter/nf_nat_ftp.c     | 51 ++++++++++++++++++++++++++--------
 net/netfilter/nf_nat_helper.c  | 10 +++++++
 4 files changed, 65 insertions(+), 11 deletions(-)

--=20
2.33.0

