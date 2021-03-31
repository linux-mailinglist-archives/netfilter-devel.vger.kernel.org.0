Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973A33508FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhCaVK5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 17:10:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49098 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhCaVKW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:10:22 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 34CC563E47
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Mar 2021 23:10:04 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nftables: remove documentation on static functions
Date:   Wed, 31 Mar 2021 23:10:15 +0200
Message-Id: <20210331211015.54607-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since 4f16d25c68ec ("netfilter: nftables: add nft_parse_register_load()
and use it") and 345023b0db31 ("netfilter: nftables: add
nft_parse_register_store() and use it"), the following functions are not
exported symbols anymore:

- nft_parse_register()
- nft_validate_register_load()
- nft_validate_register_store()

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 005f1c620fc0..f6366a3ec160 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8615,15 +8615,6 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest)
 }
 EXPORT_SYMBOL_GPL(nft_parse_u32_check);
 
-/**
- *	nft_parse_register - parse a register value from a netlink attribute
- *
- *	@attr: netlink attribute
- *
- *	Parse and translate a register value from a netlink attribute.
- *	Registers used to be 128 bit wide, these register numbers will be
- *	mapped to the corresponding 32 bit register numbers.
- */
 static unsigned int nft_parse_register(const struct nlattr *attr)
 {
 	unsigned int reg;
@@ -8659,15 +8650,6 @@ int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(nft_dump_register);
 
-/**
- *	nft_validate_register_load - validate a load from a register
- *
- *	@reg: the register number
- *	@len: the length of the data
- *
- * 	Validate that the input register is one of the general purpose
- * 	registers and that the length of the load is within the bounds.
- */
 static int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 {
 	if (reg < NFT_REG_1 * NFT_REG_SIZE / NFT_REG32_SIZE)
@@ -8695,20 +8677,6 @@ int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
 }
 EXPORT_SYMBOL_GPL(nft_parse_register_load);
 
-/**
- *	nft_validate_register_store - validate an expressions' register store
- *
- *	@ctx: context of the expression performing the load
- * 	@reg: the destination register number
- * 	@data: the data to load
- * 	@type: the data type
- * 	@len: the length of the data
- *
- * 	Validate that a data load uses the appropriate data type for
- * 	the destination register and the length is within the bounds.
- * 	A value of NULL for the data means that its runtime gathered
- * 	data.
- */
 static int nft_validate_register_store(const struct nft_ctx *ctx,
 				       enum nft_registers reg,
 				       const struct nft_data *data,
-- 
2.30.2

