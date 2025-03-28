Return-Path: <netfilter-devel+bounces-6645-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178BA749CF
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Mar 2025 13:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6101B602FD
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Mar 2025 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2DF21B8E7;
	Fri, 28 Mar 2025 12:29:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840D21B182
	for <netfilter-devel@vger.kernel.org>; Fri, 28 Mar 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164990; cv=none; b=Vnw+evbXCGK4Oojl7xXhWEp+QWZp7fx80v2j7orKQKysg5eq8Af/Qes6CkQIGWBWWhBDZKlU8GRRV7MLt6McqzMZGv5r1OPr5wLrKt1uFZMK47VLRcxoQCWQqXtcHyhuXmZ2nDMkywH2SezuQjKv5UkV6eRvIukLM7D8D4K06AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164990; c=relaxed/simple;
	bh=mjIMbNsW5v9QJnI0sr+jz3Vbe1E6teJL5kUaRSeXMdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNxopBxS2q3akYimyhKQP8FhIdFTX+zHFiQf3v0OP2z/eNKTul8Xa6KKCRZKfEwnlyL7uVH0C3miaEN6p0mcZoxPaO+5ulIjEM0Iwr0Ooed01nua8JmzFFabmFww9aIi8oDCVi0EJlIln4d9YdT54p+hgeYPESp/u9j4RFRGc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ty8q7-0006JD-PP; Fri, 28 Mar 2025 13:29:35 +0100
Date: Fri, 28 Mar 2025 13:29:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests: shell: Add socat availability feature test
Message-ID: <20250328122935.GA24225@breakpoint.cc>
References: <20250328115855.6426-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328115855.6426-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Phil Sutter <phil@nwl.cc> wrote:
> Several tests did this manually and skipped if unavail, others just
> implicitly depended on the tool.
> 
> Note that for the sake of simplicity, this will skip
> packetpath/tcp_options test entirely when it did a partial run before.

I don't mind skipping it entirely.

Reviewed-by: Florian Westphal <fw@strlen.de>

