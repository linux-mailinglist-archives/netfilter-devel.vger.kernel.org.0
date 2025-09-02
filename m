Return-Path: <netfilter-devel+bounces-8604-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54CB3FBCE
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Sep 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F337B3C73
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Sep 2025 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BBC2F39B5;
	Tue,  2 Sep 2025 10:03:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from localhost.localdomain (203.red-83-63-38.staticip.rima-tde.net [83.63.38.203])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8082EDD5E
	for <netfilter-devel@vger.kernel.org>; Tue,  2 Sep 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.63.38.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807437; cv=none; b=B8GtXieq+Oo1stVxyVENpgX8HU5qqAp1AzVQBdv/KH39zZjReCi0GuWp4IlCLylAZ1uxuFWOrN0KW5Ac80QoN4PZr6FDnYok4UAGDQ4mOvdPjmd0/6ROMGWyD+pQHQOtjAGDLgxzlx4e28MJdB7hic7TXflRGWP1Bh/ds3cNXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807437; c=relaxed/simple;
	bh=MdbAUNhZaSiWpj/wec2UZLOH/quxCTP2+PYoh+YLkqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/6AK9Vt3C9nPz8y2oetetCUQKnX1u+L1uZYqoRKpX0rI9/GZWl2HET0HbmvCFkbLntdEiZTvHweaL4Fqi8Eh9WkqV5Hc27rVfFV1Kpra+bZOePhxC3GSLZe43B3ZG9aE9kGgRKt+4BAlENOCRzJs4Kl6LBQQXUTfufLEnfpxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=83.63.38.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 024D524D5C87; Tue,  2 Sep 2025 12:03:47 +0200 (CEST)
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH nft] gitignore: ignore "tools/nftables.service"
Date: Tue,  2 Sep 2025 12:03:42 +0200
Message-ID: <20250902100342.4126-1-fmancera@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The created nftables.service file in tools directory should not be
tracked by Git.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 1e3bc514..45fef7dd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@ build-aux/
 libnftables.pc
 libtool
 nftversion.h
+tools/nftables.service
 
 # cscope files
 /cscope.*
-- 
2.51.0


