Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA9D1A0A
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Oct 2019 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIUtH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Oct 2019 16:49:07 -0400
Received: from correo.us.es ([193.147.175.20]:57746 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIUtH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:49:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BD1B21291825
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 22:49:02 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AE351B7FF9
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 22:49:02 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A3C4AB7FFE; Wed,  9 Oct 2019 22:49:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A437D1929
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 22:49:00 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 09 Oct 2019 22:49:00 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 7621F42EE38E
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 22:49:00 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] datatype: display description for header field < 8 bits
Date:   Wed,  9 Oct 2019 22:48:58 +0200
Message-Id: <20191009204858.22660-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # nft describe ip dscp
 payload expression, datatype dscp (Differentiated Services Code Point) (basetype integer), 6 bits

 pre-defined symbolic constants (in hexadecimal):
 nft: datatype.c:209: switch_byteorder: Assertion `len > 0' failed.
 Aborted

Fixes: c89a0801d077 ("datatype: Display pre-defined inet_service values in host byte order")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/datatype.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/datatype.c b/src/datatype.c
index 873f7d4d358b..0ee2925a8368 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -220,6 +220,9 @@ void symbol_table_print(const struct symbol_table *tbl,
 	unsigned int len = dtype->size / BITS_PER_BYTE;
 	uint64_t value;
 
+	if (!len)
+		len = 1;
+
 	for (s = tbl->symbols; s->identifier != NULL; s++) {
 		value = s->value;
 
-- 
2.11.0

