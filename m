Return-Path: <netfilter-devel+bounces-572-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB81828569
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jan 2024 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E56282E31
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jan 2024 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C337159;
	Tue,  9 Jan 2024 11:48:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1A32C66
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jan 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft] doc: incorrect datatype description for icmpv6_type and icmpvx_code
Date: Tue,  9 Jan 2024 12:48:34 +0100
Message-Id: <20240109114834.156400-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect description in manpage:

 ICMPV6 TYPE TYPE is icmpv6_type
 ICMPVX CODE TYPE is icmpx_code

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/data-types.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/data-types.txt b/doc/data-types.txt
index 961fc624004a..e5ee91a97386 100644
--- a/doc/data-types.txt
+++ b/doc/data-types.txt
@@ -270,7 +270,7 @@ ICMPV6 TYPE TYPE
 |==================
 |Name | Keyword | Size | Base type
 |ICMPv6 Type |
-icmpx_code |
+icmpv6_type |
 8 bit |
 integer
 |===================
@@ -364,7 +364,7 @@ ICMPVX CODE TYPE
 |==================
 |Name | Keyword | Size | Base type
 |ICMPvX Code |
-icmpv6_type |
+icmpx_code |
 8 bit |
 integer
 |===================
-- 
2.30.2


