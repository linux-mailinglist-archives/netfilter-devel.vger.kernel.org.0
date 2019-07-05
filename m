Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F319B6023A
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfGEIgF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 04:36:05 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:34375 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGEIgF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:36:05 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id BB24E44030A;
        Fri,  5 Jul 2019 11:36:02 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH libnftnl v2] Add Requires.private field to libnftnl.pc
Date:   Fri,  5 Jul 2019 11:34:19 +0300
Message-Id: <38ab4cd887af863846c651ba8fb2deef0dc770d9.1562315659.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Static linking userspace programs such as nftables against libnftnl
currently doesn't work out of the box, because libnftnl is linked
against libmnl, but this isn't expressed in libnftnl pkg-config
file:

  CCLD   nft
[...]/bfin-buildroot-uclinux-uclibc/sysroot/usr/lib/libnftnl.a(table.o): In function `_nft_table_nlmsg_parse':
table.c:(.text+0x480): undefined reference to `_mnl_attr_parse'
table.c:(.text+0x492): undefined reference to `_mnl_attr_get_str'
table.c:(.text+0x4a8): undefined reference to `_mnl_attr_get_u32'
table.c:(.text+0x4ca): undefined reference to `_mnl_attr_get_u32'
[...]

The Libs.private field is specifically designed for such usage:

From pkg-config documentation:

  Requires.private:

    A list of packages required by this package. The difference from
    Requires is that the packages listed under Requires.private are not
    taken into account when a flag list is computed for dynamically
    linked executable (i.e., when --static was not specified). In the
    situation where each .pc file corresponds to a library,
    Requires.private shall be used exclusively to specify the
    dependencies between the libraries.

Therefore, this patch adds a reference to libmnl in the Requires.private
field of libnftnl pkg-config file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
[baruch: use Requires.private; update commit log]
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
  Use Requires.private (Jan Engelhardt)
---
 libnftnl.pc.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libnftnl.pc.in b/libnftnl.pc.in
index fd5cc6ac5ca4..ef94d749dd86 100644
--- a/libnftnl.pc.in
+++ b/libnftnl.pc.in
@@ -10,6 +10,7 @@ Description: Netfilter nf_tables infrastructure library
 URL: http://netfilter.org/projects/libnftnl/
 Version: @VERSION@
 Requires:
+Requires.private: libmnl
 Conflicts:
 Libs: -L${libdir} -lnftnl
 Cflags: -I${includedir}
-- 
2.20.1

