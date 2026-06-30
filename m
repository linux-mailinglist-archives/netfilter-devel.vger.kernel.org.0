Return-Path: <netfilter-devel+bounces-13538-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w1ngHltpQ2pgYAoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13538-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 08:59:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C306E0F28
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 08:59:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hOBGnHVT;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13538-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13538-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82104304DAF9
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FB392C56;
	Tue, 30 Jun 2026 06:58:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0F3CDBDD
	for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2026 06:58:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802685; cv=none; b=WOJx1h/rDxUVOX4/5DNvAj3HG3vQAOsEOJP6FyeXGY7cLrNvLrlNUk0jpRpcXHmFmAE2wvZn7LWga1TNAw9PZpsPshKEcenB+F+LiI8XkO+qrWZ8GQGnA666dcrwJLx4S00RHzp0bPCS/Wyjeb8fjKcXXeFnxy3InUr/USzqhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802685; c=relaxed/simple;
	bh=to4R4ee8k2o5804/vpzYrLJhMjVE1Ml1XXys9wSRdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NENlNByANvaGdANKgH9ApsZ6DD69HWUhEP4XdtD5+y4pgNgX7krwApMQ3uaFIBMufZiAmgfZ07fVVf9j/+BlZqVltNpd6UrIRFtqtYwRcRxi/gOhbU0pfRz5a8/OltZx5RIhX3s3XHvOhJdivstoHqrIdcuENlsXswgXx5hLgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOBGnHVT; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1633437f8f.0
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2026 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802683; x=1783407483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=hOBGnHVT67Lt3gKYEGMm1hlFw3lhLlTyIkAJJnIuUnru8IKeAb2ZC2Z0WEQuN4rVH7
         CLleuvU5MvMMbULpAG3wyn3nsrpYp4EtQHycA6NLn8PavmMQaMHUtnWYse1G5g53xnyo
         utQOrAXbmJaT5s5pT2R3Kuv6tozZpkXh5T0FQrt2XUShlWHogR9dL5InbZROChKWHT8m
         wqnOHuy0jlxzecRhwFr3G6GBZG1eJkTyIMlwkfQ1/76nhuywMAwdgElucBls/wUcY76i
         AlyFlhQ9A1AzVdEEb0kQqV2osxU93gx7jC3Vzmhy7SRgE73Qc0TmzCB2KzN5EQ43gnOr
         LYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802683; x=1783407483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3SLRCeShC2U5Lb0rTb1U6hkwISYxR1k50UcKsPQ0QE=;
        b=Uemgm5fXV25VHBsmu1UdsaP0BjaXT5g3wufSXBrHaErQW9UBfM/nSd/mkn37GMgkwN
         x8E8wIISjPvxmvQH+zqpkLg7JtBgG3xBQ9OewJeCcs0suhLtbr2+ZJ2UHKqZJV4Q1+UV
         C20TL+MW4mj+lrpg871sNOaO6v0Baps4JK9yd9YFUy6+TuRJy8et4SePrxBnyTF7s51n
         DnqE77+8YzVnkfyO9uxe6+GPmo9LaCYWYSmYURfkDz3A8pDphPod3JRoQ5MMTjNC48Av
         IEslXaIGi8fI876aTovdtM1k1et/ncEWq7XjufE0B/pHQvKIfH9ZdOa59E2xWT20KL69
         htbw==
X-Gm-Message-State: AOJu0Yx0wUCun6tq9BTRvnG7ilsVMNhF86pZXHKC0b7yYNdX5zIdnZ6d
	DmCnwY13NtaPrGwMEkOBzShwti5hnGJ5jbICoquqFFp2/G96sz5L+RkUc02XGavx
X-Gm-Gg: AfdE7ckyC8UEhW72wkIT3IdBUtRaZO1fMLmygKPZbVSVk/e7+bnnaBNc07egXVpoE6y
	8EbTZ3AO0SdcSZ6FogJ6RMvWbYbhBIOsr1wrrCiOLrSClDF1lJ81nDQmuaa+9A72UnHEMc/Y8Pk
	KSy8lz0i4FbyNV7Ux5KKBByCCgkOYyTXRIHZzKfwvSSoQxNt/eULMlTTYtkjSWGOYcTNVgR+UjN
	GhNtqDzNnlVLb9E3aIN0RcleKt5I98ZnE0pM7bqXV55lxV/Y4E0sqPk2nEfIjamK3062UeRTX5e
	K729nanWjP9ZwEs9lU3ZSwTuXc+OajFRNYJGPz4ANt3MHOzK3M9X+pMDn89QfqwaN6EV04y8O4U
	HmvdgPno8LhXlgc1DZsZEQ1Efv2l3TZJDUVOMxYFVuleFq/d1HQ4KqIkCQ38B7WTTMY0lSGoovb
	kjyV8Eo18=
X-Received: by 2002:a05:6000:2c03:b0:476:135a:1349 with SMTP id ffacd0b85a97d-476135a1477mr139610f8f.6.1782802682657;
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:58:02 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 4/5] netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
Date: Tue, 30 Jun 2026 08:57:34 +0200
Message-ID: <20260630065735.3341614-5-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630065735.3341614-1-pawlik.dan@gmail.com>
References: <20260630065735.3341614-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13538-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:razor@blackwall.org,m:idosch@nvidia.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:rchen14b@gmail.com,m:lorenzo@kernel.org,m:pawlik.dan@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,m:pawlikdan@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,blackwall.org,nvidia.com,gmail.com,collabora.com,lists.linux.dev,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawlikdan@gmail.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C306E0F28

From: Ryan Chen <rchen14b@gmail.com>

Without this change, nft_dev_path_info() hits the default -ENOENT path
for WiFi bridge offload via WDMA on MT7996. When a bridged flow goes
through the MT7996 WiFi device, the DEV_PATH_MTK_WDMA step does not set
h_source, causing the PPE entry to receive a zero source MAC and packets
to stall in both software fastpath and hardware path.

Based on a MediaTek SDK patch by Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 6c470854127f..580aa1db3cb4 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -219,6 +219,10 @@ static int nft_dev_path_info(const struct net_device_path_stack *stack,
 			}
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
+		case DEV_PATH_MTK_WDMA:
+			if (is_zero_ether_addr(info->h_source))
+				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
+			break;
 		default:
 			return -1;
 		}
-- 
2.54.0


