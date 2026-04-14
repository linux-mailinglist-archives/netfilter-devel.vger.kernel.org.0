Return-Path: <netfilter-devel+bounces-11882-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMbUA9tO3mndqAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11882-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 16:27:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1AA3FB2E2
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FA2430131D3
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602153E868F;
	Tue, 14 Apr 2026 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdvjplzh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4913DCDBB;
	Tue, 14 Apr 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176852; cv=none; b=iLrDEUTXoPOlMLKwNWywb+R3RrhG7mYJZmGXGhTXGmrN8fRpeyqmzofn7ovvSENpMO5k0eG7OIVGIWYZmzo7eNh6gutm6CsgqDqbL9QBNHMbOs8eqfRtvAPCj+zW4AL2W5qF/B/LyWY5kd9GnzOo/zfaf6mPHbkTRjMFodrGcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176852; c=relaxed/simple;
	bh=i4xJrdkZCNvCqgwxr9JrQ53AyB8oPiIGtsM7/BoZH/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGSCZGFbVIGL9vPNsHzTtIvKcPeBehoyw9IMEiDHa2+XkDnp1GVUHagCbOTFDxTFFt60qD8XtW5ayavncnTBctuaJYWsujJOyfKoE/0vztpIcaiRGUTc0b5J5ETk1biWUfyUIo9tSPOMQvg2QJEXisIEEtgsh2ruNUbMw24Usck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdvjplzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45911C19425;
	Tue, 14 Apr 2026 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176851;
	bh=i4xJrdkZCNvCqgwxr9JrQ53AyB8oPiIGtsM7/BoZH/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdvjplzhW57JqjM5J9cfK4l+AJSCFCpMNxIk4cDg6he8jr/pL5Z7ocEussyMGTUoE
	 jqL46ln4lm6K/uvTL4g44YaQBidTTMXp7KdHNVJGyyuCkU3QZ8TkWxQdMDXGe+AgQe
	 KTSagB/eI/SPWcBioiBR92vVXLhxjvkV86p7Xb3lctjeQoPZ4JpD+7NM6nBvyUXh9J
	 ptR2UPd6P/WtF37a7t7TE0qCaJcnVzHMpjuAFK5kUJMWoBHyJ+Ku/Ry89cW7HOa+XH
	 jvl/zErZaYA9fuJ7L1BkHiWLdKsFtiufkQmyDtAWZBSSbqyeIOE0lEnrhgtigkYbnB
	 RSLk+blN1aPmg==
Date: Tue, 14 Apr 2026 16:27:29 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch V2 11/11] alarmtimer: Remove unused interfaces
Message-ID: <ad5O0RO82sKUeBFt@localhost.localdomain>
References: <20260408102356.783133335@kernel.org>
 <20260408114952.670899355@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408114952.670899355@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11882-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 0B1AA3FB2E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Apr 08, 2026 at 01:54:33PM +0200, Thomas Gleixner a écrit :
> All alarmtimer users are converted to alarm_start_timer(). Remove the now
> unused interfaces.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

