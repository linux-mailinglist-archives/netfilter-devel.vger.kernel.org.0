Return-Path: <netfilter-devel+bounces-12055-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AeyDPk05mkGtgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12055-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 16:15:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C342CCF2
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699E23200FA9
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFE3ACA4B;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="memUiOfi"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41A3AC0FF;
	Mon, 20 Apr 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691293; cv=none; b=obO4kK9vDvx1lOO4dmOJkKIliFs5thWqaWMXarIJo/6gantMS5Kd7jQA8XOEuyD/DPn/YtGmYNeADt4iCN+Yo2xk9xHQlAJ0JFkhuoJSgXUbSVmhZvfq+qMWOoUg6WpMlMSOgimL9vl42DRHySesNXihvRro/l+jZ9Owk2IwI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691293; c=relaxed/simple;
	bh=jLYlSZHc3tlHuGyXMp2efSSVNqZ5cMRMFMF8BfYRzSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2JqATEvOU8lk70+MSMFqK6Z1ZjVWGf5QzpCaY+4KTWvsXvLj5q6LCU8qXioyPxjZQiRgHeLh5W+GUk7s3giSu7V1w4/qrPxX56DJc+oaUGrRTEwtjNKqos7/xzcb/xhcwM04tsYQ2qgFOVmcuLmYvAdgrYEkSD0UYti9/vxaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=memUiOfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398EDC2BCB6;
	Mon, 20 Apr 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691292;
	bh=jLYlSZHc3tlHuGyXMp2efSSVNqZ5cMRMFMF8BfYRzSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=memUiOfibntsaLPP/c4V4yIw3bl+pEuSVzZOxEYZrWWjxlXOpx8x2j/CUN9QXEvUa
	 mBlpnUZ67ULradwCf+iWNGetpy4COTPXI343laKX4K74F2FJ61+oeATJcGUe5z6e4P
	 EHAKnyrEKodblMsTQFyOZ1orfGy4WcPUSj9XApw4ZNO24c7YBjS6nAXulaeyqqyJ1P
	 Io+8MlEHZjQ3UJFY26SRds5USWiGg/7Q48X0SzwuDSOy+iJNfqFEjVuTXhUW5qsIuO
	 Ytz1ZXpfaRKdx+h6+iW9fx/z3CkRM8R17FK1V4NZO5PR7nBaZLNVPf7MeSFNmoW28r
	 2o1sYAIl4BYsg==
From: Sasha Levin <sashal@kernel.org>
To: Li hongliang <1468888505@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH] nf_tables: nft_dynset: fix possible stateful expression memleak in error path
Date: Mon, 20 Apr 2026 09:21:14 -0400
Message-ID: <20260420-stable-reply-nft-dynset@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417081855.3253507-1-1468888505@139.com>
References: <20260417081855.3253507-1-1468888505@139.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12055-lists,netfilter-devel=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C15C342CCF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026, Li hongliang wrote:
> Backport of 0548a13b5a14 ("nf_tables: nft_dynset: fix possible
> stateful expression memleak in error path").

Queued for 6.6, 6.1, and 5.15, thanks.

--
Thanks,
Sasha

