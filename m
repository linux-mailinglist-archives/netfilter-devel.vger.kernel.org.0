Return-Path: <netfilter-devel+bounces-6986-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADFA9FCD2
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Apr 2025 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB041A86ED5
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Apr 2025 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE722135A4;
	Mon, 28 Apr 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="GnruPyhz";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="OVFOwJ69"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB7212FBC;
	Mon, 28 Apr 2025 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878402; cv=none; b=n82gV3XP9zSNsEla+o4FmY6yarBun4HVRuzxpFov2d4Yv4ttSYX8P9m3Z8mwZZ8EYSrWzGmlsLGnIuVHs7oNlxNPB4oXZm0vxCiPIPaeD204u91cjvnkV8hxSH6kYuwxC+Xaf84XB4j4kWv1yQHYW2x3kroTFvHyfIzCNlqNm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878402; c=relaxed/simple;
	bh=Obpy6Gk9BM7Cii4f8ARMhEnscTfegUK0L4kYnsY1s94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oh6L76SGtYmdj08QLnxl44gr9LQf3q6NPK7NoSFRXJJFlGY+8/QFageacWeW/Ng/Y0BsBgVn61rBdLJ5OCJJHuULE4wNXGLGwJGmkP5MpBggaHXnxWeI9H6E+Sn61fHGHKqqCxwTOUGwp55xN2m8EmYEy1bD90kPFfTyeT5nNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=GnruPyhz; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OVFOwJ69; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id AA11B6054C; Tue, 29 Apr 2025 00:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1745878399;
	bh=/EEmQF7EDJiKm8KlBu3EyGVNLb/l73f/WI9g4RoKC6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnruPyhzFcezZIhU1EydlmbnbhiEnvvRQWx0gPpQ+f4D4VrL2NA/Lr58TbbcD/Y5x
	 gQVYESQK0DqF4JD7EZj9oalNPxK4SepmGZi+c1OT+TKPCYH75JLVS2KOY6v+u8Jc8g
	 oiILj+He4ui3sfJa5rEPEMXQcdve3rp+5SjqRGb2/usI6cbMX9++Mtod/k3C2ALe5m
	 rNiHcS1/RbQ7sgOK9D4A8iUvxKVqrGtFrjeXzE6J0dDi4Pb+T9WDHMVt1WHq8zaX5U
	 VIOegYwhjXuetaMADmpNWvpNSEjHg7NN8X+k7LFjSqxa0P3C2QS5hFqrxrENyGJzxE
	 Abfzg78hEJ15w==
X-Spam-Level: 
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C086D605B6;
	Tue, 29 Apr 2025 00:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1745878396;
	bh=/EEmQF7EDJiKm8KlBu3EyGVNLb/l73f/WI9g4RoKC6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVFOwJ69sbSuDHwR2RmArvi5mB4w3EOIwgAPuFmoi26dWIoxO4PGYuRrIMKfo/e39
	 W8jr0Jgrey5KXtU2HbQYpQhu5gGsvEEHGegwRff7trjEZnaTO+5W46LObpr+BgSwKH
	 xZiZ4//mXW6ahztZwfBTfv6iErlfJHJ6XFOWNSLXlQNcD9Ant5OxxBm1hkJFyTiCZ3
	 Ee7YHRgKXfluNmxgQUIagcTJ2QGkDrNV5MedBCmR+Ean/BBwduA3DA4nruMHhRMSH9
	 R7nvOT6cns/8jzixH6JEH5ipjYSSgTHkmTzpgAz0mMeyVHEoUyRasDC9eCj9NLGtR6
	 OuhBAZTJJPueg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 5/6] docs: tproxy: fix formatting for nft code block
Date: Tue, 29 Apr 2025 00:12:53 +0200
Message-Id: <20250428221254.3853-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250428221254.3853-1-pablo@netfilter.org>
References: <20250428221254.3853-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Linxuan <chenlinxuan@uniontech.com>

The nft command snippet for redirecting traffic isn't formatted
in a literal code block like the rest of snippets.
Fix the formatting inconsistency.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 Documentation/networking/tproxy.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tproxy.rst b/Documentation/networking/tproxy.rst
index 7f7c1ff6f159..75e4990cc3db 100644
--- a/Documentation/networking/tproxy.rst
+++ b/Documentation/networking/tproxy.rst
@@ -69,9 +69,9 @@ add rules like this to the iptables ruleset above::
     # iptables -t mangle -A PREROUTING -p tcp --dport 80 -j TPROXY \
       --tproxy-mark 0x1/0x1 --on-port 50080
 
-Or the following rule to nft:
+Or the following rule to nft::
 
-# nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
+    # nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
 
 Note that for this to work you'll have to modify the proxy to enable (SOL_IP,
 IP_TRANSPARENT) for the listening socket.
-- 
2.30.2


