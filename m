Return-Path: <netfilter-devel+bounces-7834-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAECAFF2EB
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jul 2025 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831571C20AC9
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jul 2025 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9F2243367;
	Wed,  9 Jul 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xavierclaude.be header.i=@xavierclaude.be header.b="V96tkZB+"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D20238173
	for <netfilter-devel@vger.kernel.org>; Wed,  9 Jul 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092593; cv=none; b=KLozJLHjHeoi0rJm1npl+EX5DLSg5eS5qFD7pqLV+vXiCglwn/L+NwGGIoW1mLfmnRMdPntwu4jrXgk2XI3/giliyWEckx07b+/njQTld5rOmsOvuxoVHk1O1l88UUJiKBw6iV3irn9ryy3KNsCptBJXKP+90pl57choga3hVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092593; c=relaxed/simple;
	bh=hN8SSub7bi8nAJZE7vLcqT1wt7335GjR2f7Xgh7AiRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT5yLqMSPJMt7Em1mSC/a9H0EX+NPLAYio4Cyor7Yt4jeE04NeiOIePTmieNlnCkNdNmnrvsrmjJ1T1q6pyfy3eilDWKHfGznvg0JFFZ3rV8KP54XCaXQWUJSq8SlAvE4N+L0NPk4DkGE91WVqM7+lSQpcq7MXbtDzYg0JXUX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xavierclaude.be; spf=pass smtp.mailfrom=xavierclaude.be; dkim=pass (2048-bit key) header.d=xavierclaude.be header.i=@xavierclaude.be header.b=V96tkZB+; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xavierclaude.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xavierclaude.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xavierclaude.be;
	s=protonmail3; t=1752092587; x=1752351787;
	bh=hN8SSub7bi8nAJZE7vLcqT1wt7335GjR2f7Xgh7AiRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=V96tkZB+RyV5hsvx6WBnxjxX18TCRmdYB0B3Tz/mq7x+j0MYMSmkoiFV+/FTemd9k
	 Ty5D1TRHYUAAxknHqwqbpTNjuacxz8xLOcXzp4fSHCJ3HVirkZGgRWHUb0W814tW5x
	 pnAzNGvR0MCsp45QbyJy+kv3VQuFX0Faz4Pn6g9ObRhKjw9e0oZxEs2rVgEQIDKZI1
	 ufQkcDOK97SM83r+CcYILkbsuXvJl0LbDKUqABEn0SvYbA3Z8urhTZFsFUWOizEcD3
	 znJ2jW1uRsq7i6qNzu/6d4IKjseNfwDoX4jXWx/PX9ThSAZj9sMruECpeKNhGZKBDK
	 ryXhfR9A/Bgzw==
Date: Wed, 09 Jul 2025 20:23:02 +0000
To: Florian Westphal <fw@strlen.de>
From: Xavier Claude <contact@xavierclaude.be>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack-tools] Typo in contrackd-conf manpage
Message-ID: <1835833.VLH7GnMWUR@kashyyk>
In-Reply-To: <aG7MxJpZsKsKEwjo@strlen.de>
References: <3365321.aeNJFYEL58@kashyyk> <aG7MxJpZsKsKEwjo@strlen.de>
Feedback-ID: 36077759:user:proton
X-Pm-Message-ID: b6c2715a0c78e447877744a67c281be253545a87
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le mercredi 9 juillet 2025, 22:10 Florian Westphal a =C3=A9crit :
> Next time, please send the patch to yourself and make sure you can apply
> it via 'git am' first.

Thank you for the manual import. Sorry for the garbage. I checked the file =
but=20
I must have made a mistake when importing in kmail. Next time I'll use git=
=20
send-email.=20






