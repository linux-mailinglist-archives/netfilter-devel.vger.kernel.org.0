Return-Path: <netfilter-devel+bounces-13358-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 743QHb1/NmopAgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13358-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 13:55:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6686A8D39
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 13:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CMZnVmXR;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13358-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13358-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A89243022DE7
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C63932C3;
	Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0F392C28;
	Sat, 20 Jun 2026 11:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956508; cv=none; b=tMokOOHmPdnHV7sZeRM8aVofwBeXLnO3h05bs1cs3jS/pIiTZu5C1iuV87Oe+C9Y3yMCzwdeNhMpgWX5ZYU6waJGkN3faePUazO7QM0zPBumGEfppv710rlKsOBljX9OGoep5w/tW7caRyUkQG2TlKIbOB6+9rPIPLUiJTmFSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956508; c=relaxed/simple;
	bh=GrkI7+TBzY8SA8Ry5eLxaHWyBkc0ocX8WALmjWR1HBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/oLyQU//CF/mEFvcCtjU2YHW0fsyAv9OYPUI4ctU0aDnAgGdpMw3CdTNHIiGWfIIbgHak0Pcu5MJ/50FnzApgFkrVW6H8ZmZWY+NnXCw43YwumdxMshIbDclG4DQEIkf3phQVfsI5xfYqGKucisu5O5OeBPzUhNjoYMn6V30BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMZnVmXR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFBE1F00A3D;
	Sat, 20 Jun 2026 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956507;
	bh=hPnk0R8V3mCAmK/6KNk62qrYp7PI24nMqvfDkXFCGEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMZnVmXRDx8b5/A0sghFqKlV3GySuuJJDHPdTSLUr1xmDdAXO5lf/PwWXJGdbPqVn
	 V6Qj6nY8RMogTVXz7LyKDE7T85D1EyASzFhCVaZKFyQwkz9xXC/FP6FomU/oZJeF14
	 U/V1Aqleky+wJeQH+4yh5RhGj0I9PpfnT2eKL0H7iPO3dz/kupPxwYRP7AxQ8IW0Cx
	 NW/geufOwud5oF0ND1opX1Raae1cJG+mrLM10GuIvQlktXp1HZ1MFb9gUQy57mGAOu
	 TKR/wMdEgSDlIYTEgStuJubvj1d81yutP8PA9CdJEVb3jzqttHiVbKAQruQ3FtZ6bi
	 tqAOmdl9bHfXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Yiming Qian <yimingqian591@gmail.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH v6.6-v6.1] netfilter: nf_tables: always walk all pending catchall elements
Date: Sat, 20 Jun 2026 07:54:54 -0400
Message-ID: <20260619.0004.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618083438.1269242-1-shivani.agarwal@broadcom.com>
References: <20260618083438.1269242-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13358-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:yimingqian591@gmail.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,redhat.com,vger.kernel.org,broadcom.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D6686A8D39

> [PATCH v6.6-v6.1] netfilter: nf_tables: always walk all pending catchall
> elements

This one didn't apply to either 6.6.y or 6.1.y.

-- 
Thanks,
Sasha

