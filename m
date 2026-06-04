Return-Path: <netfilter-devel+bounces-13051-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XtmJEmEeIWoi/QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13051-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:42:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88063D4AF
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:42:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=HJDS7hex;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13051-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13051-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0ADF301907C
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7F3CC7C6;
	Thu,  4 Jun 2026 06:35:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A933CDBAA
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 06:35:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554927; cv=none; b=IraZoJoJbaOwZPYJMccycyup9GS8sp1gi3RmfUO+cQjCkbjDyw7oamju7i1PxWTUKuR+LaMafUcMldnj/fylpU/Hww+doEK0+P9W3l0Cl3qSnUMSguLUc4BF8I7NX+fPDPV1+PQrRQ/FFc+KgMvBSYRfmFf3RJ7GLEMGcrQml2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554927; c=relaxed/simple;
	bh=HGgvWm7/0UGfX/UQWmiozUVCbKqWz18zhSwakXhbxfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBbTyMUm1GY5NpS3MM3vKUeBWWmMeXnLo6Guv5VKW6vCpWegCNnaLb+YZlEBA8idVVboGKEz7pIKLCrskADx6UDNvARzaS/MPmdPS99JhUKynMBjEThmJnOvR88OM4iXzZu2aVO8nXvKEhdw3ExVaM6VxqZkw96CkCqsVXSJuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HJDS7hex; arc=none smtp.client-ip=95.215.58.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780554912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGgvWm7/0UGfX/UQWmiozUVCbKqWz18zhSwakXhbxfk=;
	b=HJDS7hex4P+bDQ4/ek//YftQRthJ2CT/jGi0AVnwRo54wmaNqMDqjDf8GGcJdG4iWmxPuc
	Q12LI9aPtB6El8WgKTFgYatMzclB9obVPjDcB40GPii+KSIp4PWswQO73/zmE5oieAGnr9
	1Q9Z0wHHMqsoJuSHvD4Dt97e+YJTnNg=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: flowtable: remove inline segmentation
Date: Thu,  4 Jun 2026 14:34:49 +0800
Message-ID: <20260604063452.1338-1-qingfang.deng@linux.dev>
In-Reply-To: <20260603025047.32839-1-qingfang.deng@linux.dev>
References: <20260603025047.32839-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13051-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:qingfang.deng@linux.dev,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[qingfang.deng@linux.dev,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B88063D4AF

Hi Pablo,

AI says this may pass GSO packets directly to underlying drivers (as we
bypass the ppp interface) and corrupt their packet headers:

https://sashiko.dev/#/patchset/20260603025047.32839-1-qingfang.deng@linux.dev

Do I need to set skb->encapsulation like you did earlier?

Regards,
Qingfang

