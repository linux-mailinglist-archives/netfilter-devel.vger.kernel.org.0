Return-Path: <netfilter-devel+bounces-11511-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN2ALT1oy2kIHgYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11511-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 08:22:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5336472A
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CDD301C8B7
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A2D37F745;
	Tue, 31 Mar 2026 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyaehuUK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579534CFCF
	for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938079; cv=none; b=moaJ2O4Z1OvNkx93smWkm/Ny6zSyucFsr3cSRrcUeLMjnn50xX9PtPz9VAeNZeotcyfRmRZgPOk/WpCMTjQdOetOYK5fRc1Sdvy4UZlYWJWjDubcpnmOsUNJLpSegk01s5IriJSsTBLAC/Wdo04f1LbEPszhZrWU5UMMlDmXLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938079; c=relaxed/simple;
	bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1JAO8dfecY26S4qOpywvm6YbSwx2I/9YrodcNSbriiG0WJdAR/VbOCb/oP7V93fQi02h2nlxmpXvwvmaMFiZQ6t+h/PyO5MybGZSFu1FLerr+3RcgFgjBpV7O84dx9u8eWldERfKavWdyJkWTLKCjRfatk3UJL8fqQYxJpDrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyaehuUK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce0a9b41aso49609b3a.0
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2026 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774938078; x=1775542878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
        b=KyaehuUKMiPsSs0lLGiczKiYeYQxLMkfuk3ie1vMOn8n/BVVswn4HPBUXVX1HkgXvt
         k5UA1vBkPqskDXcVhOYWP1PMVRPJGx96RX1kTkqlEnqP5s0uFm3aEM+YrPvwszKYCqYa
         yGHhW+SO6FgIzzug9RFo5DTLk5srMVJgHNgVpEOjud/AvGRZV5dCzigf95PofIS/vjqk
         UBVhmJMEG7cauXWlmyw95PEI1l7+EnKfsJIOTpmIIEnQEVdzif81LQM7U3rSL0Qwn/A3
         gLLBZJpkkx14N7Q2DrBbx8olSzn79YYCzMR1YOhtEmtAt46BICc5LCnMhxW6pEFDaU1v
         xYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774938078; x=1775542878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+BgWTs2LBjFSXlYSbG7Dx22AT17F/RZ9tqj1xZgmWQ=;
        b=IvuP9M/rVWHOscX3JE4uiStXaHaR2rIa3jegKYv7fk/j1zVnDkRgvzKhZeAGVXhQXp
         gDz+bJKvh4XsC/k2cIk+O78cuN7+r0RUGYnnav3u2N+p8BW1HinOH4ciME+s1LhJfTNz
         IvDmvtL2b8WjKhuAcWuMs/Jpj4EpGXZ41NrczvuHNii5z8dTy76N003qG4bwzeA+DVbF
         pc0aPBk0Hy5Hzh0BrhKbzAkWbwA86lfQgh+sffP7yQWVbD6NTUOfP1VwJ6Vlb52wuu7d
         WdedQJ21JE7ir2dQliQ2mV+7x9ZL3LkdTUpZ6IJ+6C/VPZSfeC06OYajzHvK1RYiuqDC
         41/Q==
X-Gm-Message-State: AOJu0Yy/gfnm/B2o4L/asgb9EHazUV4InSIKO3hn/a2uH20nfwNPbsYN
	WpGG7BDVbHVOex5O7wgk8/zpCp99I+pcFrA62QuHHcCl3EL/ZBiyIAl7
X-Gm-Gg: ATEYQzxpKwpnK/envbGEvCOFF4svSMJCa0+6LCo5lX5j6VaiFg0mGwHHhECwBIe0Rsj
	mUxKisvrFgxDPTlzEoN9kpmHlDxOD2/FpxwaQfHvxmJySKFezJHnMf6Gb+BvV0VzHHA+dUllF02
	DuljX2+vraiM03QdCYsiiWALeolDtcAKNCrQU5b2NDN0qnOw8tWr+A47B/D7MFNth2RASGXmsof
	q/EB+wi5jAdrG3nvWhdKqzk/iZ0S2cPGiV90/WZbUV5HexpNmlb/KztE688n6/U0g3qH5XKpQx9
	2LSKs1WYvo9z+fTLQ4vXf/exy7pCL2HydgWVtzzr2YZEwpiYErnSM7gH/uC6g7mY4t8BJK27XEE
	di6iE+azbTm/HCsfMAzN+qLumMGnrWl/vQ4wY9tsXHJsxJgJLoCA/GmGlbnE38kntjXfP9b/LZg
	T6V3x1DmLYPJK7KFT+rMX0n5HbNRVyopoMqow=
X-Received: by 2002:a05:6a00:288e:b0:82a:64c7:8c6d with SMTP id d2e1a72fcca58-82c95e5bd1amr13385091b3a.25.1774938078015;
        Mon, 30 Mar 2026 23:21:18 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d3a71sm10696398b3a.30.2026.03.30.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:21:17 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH v2] netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
Date: Tue, 31 Mar 2026 14:21:09 +0800
Message-ID: <20260331062110.87551-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331061434.84238-1-tpluszz77@gmail.com>
References: <20260331061434.84238-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11511-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BF5336472A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please ignore this mis-threaded v2. The correct standalone v2 has
been sent separately.

Qi Tang

