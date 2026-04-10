Return-Path: <netfilter-devel+bounces-11792-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG+CG6nQ2GngiQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11792-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 12:27:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2713D5AA0
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 12:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22539304C12B
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26237B01E;
	Fri, 10 Apr 2026 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNb/tKl5"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656E329C67;
	Fri, 10 Apr 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816413; cv=none; b=Pla3kNh/zJqBsHc5dnlFPCfCwFU4515tVF37INawm88T2u16nBtFRCbg/kOClfJCyuAYBkrc9JKtBawoCT8ZpDzw82gycHHukfeX6ja8BbmGVu/Kytrq0d8b+teAmAy4IiDSePIZJnh8/LG+hIJTz+jG+eWOlAsBLb3ewuFczZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816413; c=relaxed/simple;
	bh=KWb5/jmAk10UfhNvrbw8u9CU09mcsX2bncAWPbXDiMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlqZujywQ0LnbepZCNvc3QmMDYMq15N4a2kYOjViOsbbDrMQDimKTCcsw4Xsk8jteAbAxKbRKOyPlhmtWXVi1RQuYCagb10rV1iaB0J5eAc7vim4vg0Kix2ckQIWKujAVcOWcY+ydgVDVPDtqHxftvhVYkofxWIE7rtRXX5a3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNb/tKl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F735C19421;
	Fri, 10 Apr 2026 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775816412;
	bh=KWb5/jmAk10UfhNvrbw8u9CU09mcsX2bncAWPbXDiMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNb/tKl5gQcgrsD4HoB/WsKlT4pYq/gLGFcEOiCMg937UaCHIJV77uyGpuMo0DoU0
	 1UZo9rzoTRHkvsqthqIvN5d4sZoRluXnOXGHXKs5o7vsQt9fA2qmUQJp1wp6sO/bKW
	 h0E1l6wkvdlRt6kj1n5yg9G15RJ14hSVEvaGACXV1QIPJSb8p3s1NTNC28DNhn0Wuj
	 RDd5sATs7MSPxEVOkNQUhj2CO72wu7WtMIVu7T4qiXxaDzmgUmiiXrNmB6plkeBxv8
	 feE8v/wl+0tO99pfNEevK6rcBTTxbEKnSczs4CQOkhf+U6dv9WnA73ftPe0kxROi05
	 NDU5UWqcCppIQ==
Date: Fri, 10 Apr 2026 12:20:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Calvin Owens <calvin@wbinvd.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch V2 05/11] posix-timers: Switch to
 hrtimer_start_expires_user()
Message-ID: <adjO1yvB2akP7iKw@localhost.localdomain>
References: <20260408102356.783133335@kernel.org>
 <20260408114952.266001916@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408114952.266001916@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11792-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:email,localhost.localdomain:mid]
X-Rspamd-Queue-Id: DC2713D5AA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Wed, Apr 08, 2026 at 01:54:06PM +0200, Thomas Gleixner a écrit :
> Switch the arm and rearm callbacks for hrtimer based posix timers over to
> hrtimer_start_expires_user() so that already expired timers are not
> queued. Hand the result back to the caller, which then queues the signal.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

