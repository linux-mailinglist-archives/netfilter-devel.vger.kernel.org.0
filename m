Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA628CE38
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHNIUT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 04:20:19 -0400
Received: from correo.us.es ([193.147.175.20]:52824 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHNIUT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:20:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF53AC4144
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 10:20:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A037421FE4
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 10:20:16 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 95C71DA730; Wed, 14 Aug 2019 10:20:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5FE93DA730;
        Wed, 14 Aug 2019 10:20:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 14 Aug 2019 10:20:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [31.4.218.116])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 14E004265A2F;
        Wed, 14 Aug 2019 10:20:14 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft] gmputil: assert length is non-zero
Date:   Wed, 14 Aug 2019 10:20:09 +0200
Message-Id: <20190814082009.27595-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Importing, exporting and byteswapping zero length data should not
happen.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Probably this helps spot more problems with s390.

 src/gmputil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/gmputil.c b/src/gmputil.c
index a25f42ee2b64..424a83842b8d 100644
--- a/src/gmputil.c
+++ b/src/gmputil.c
@@ -94,6 +94,8 @@ void *mpz_export_data(void *data, const mpz_t op,
 	enum mpz_word_order order;
 	enum mpz_byte_order endian;
 
+	assert(len > 0);
+
 	switch (byteorder) {
 	case BYTEORDER_BIG_ENDIAN:
 	default:
@@ -118,6 +120,8 @@ void mpz_import_data(mpz_t rop, const void *data,
 	enum mpz_word_order order;
 	enum mpz_byte_order endian;
 
+	assert(len > 0);
+
 	switch (byteorder) {
 	case BYTEORDER_BIG_ENDIAN:
 	default:
@@ -137,6 +141,8 @@ void mpz_switch_byteorder(mpz_t rop, unsigned int len)
 {
 	char data[len];
 
+	assert(len > 0);
+
 	mpz_export_data(data, rop, BYTEORDER_BIG_ENDIAN, len);
 	mpz_import_data(rop, data, BYTEORDER_HOST_ENDIAN, len);
 }
-- 
2.11.0


