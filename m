Return-Path: <netfilter-devel+bounces-13456-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sPIlGKZKPGr7mAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13456-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 23:22:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8906C16F3
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 23:22:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bmOKF9ff;
	dkim=pass header.d=redhat.com header.s=google header.b=lc1LPOCp;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13456-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13456-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85003300695A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF13E5EDC;
	Wed, 24 Jun 2026 21:22:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB21F03DE
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 21:22:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336163; cv=none; b=QFzOS7G6rVHT/p+XAkIfuoOA6PC2NAHgOCy3gv2V8alotVlrCjG9Bs5ofMJkchU3Lgz6Eq1zFR2/O2XB5gxS+NesPvGIYMgPq9KvwT9NqD4sVpz0rJuOQAPjBWXaBSfVn5ZUGG39A2QLZqF+x2lc6XYSdnKRc4waATvvM6VD+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336163; c=relaxed/simple;
	bh=qcQFEqU0aFUk3rx7fYyik9HrZulXRDdbSfHekZbr9bQ=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=gb87CjAvdUrh2uIySYxIx+gmgPyTxx6Q7MLR6XgJCiRSyw8RaKFIBkIeYFT7+/bh6H+rjWpWB9Hx2Q3/21m+Y7juZBhtrNorpleGPrJLdHKEsqY3DpXbMcbmDiQ4VD+GBCpzqW2ayFJ3GxrZoimp41KntiD0HT4v/vJtn/UhL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmOKF9ff; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lc1LPOCp; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdaShem5APu1V9lcm6Uqc+Zqcrnxdo3Me9ZHHDuEGAg=;
	b=bmOKF9ff0SGzRM7r80ZMMvSnd0UlXjYstR4nRl5/46nixBdeUQyV8hQswGAuSG9im8jULm
	fcYMDVwnu/dzK9EjDXRVR/S+A1g6jun27HjlKb03IARZFnTV+SDWCKF/5vToH00II/ArLn
	v4fOZQ3LLrbcD49hTIqoFj5uGjLcxC4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-4AxMcYekOpSM62EfF3IUEQ-1; Wed, 24 Jun 2026 17:22:38 -0400
X-MC-Unique: 4AxMcYekOpSM62EfF3IUEQ-1
X-Mimecast-MFC-AGG-ID: 4AxMcYekOpSM62EfF3IUEQ_1782336157
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c56e2576so9682095e9.3
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782336157; x=1782940957; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdaShem5APu1V9lcm6Uqc+Zqcrnxdo3Me9ZHHDuEGAg=;
        b=lc1LPOCpWSLWydkTTP1MNQGbqVu+g1LLP1oo48+S5tpYfKHLPLKRti+h47I/8TXFc1
         7FuTdziuK3LOovm338nJx89C7f7GSmiSr0yMgN5MRePzE8Kw71F/10718p+JISi3z5c+
         MnDrC7yZ5/DeJPWvrN5i7x14PrTfymm42eU5IvJoabzYcFGKqDSnJFGfey4DJcWAJEBj
         +5FNWX6UOIcMXqzEwcPIJPnFTEZK03y4iwK/rtSBGJtLWSgC039/brcSXHq4MPGPf7Fo
         0kEtsthcpJ6dc5w8BVykIi9X6j26NYKeJst5mvZ5TcWle3sV/Oli5t3Fim0qUMN+JJZh
         GZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336157; x=1782940957;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdaShem5APu1V9lcm6Uqc+Zqcrnxdo3Me9ZHHDuEGAg=;
        b=EmI0LM3sRWo8MN8FLkHeZyblBPzmznw2VUN3zcJHmbZwimVXby6xmcXlyh9pCy1+g2
         eUoecMRO0JNpqhDfjV/ysJGrd9I7ZPRuS/2v1CkSimSAWMQ0geICCi4LirDy/MSGGUOD
         59S6bdr5zZAIcVyyePVOtgxdFqm9WQxwC9C+xOrCBRGFjLf8jOZrPDuekErA8nBKmb/r
         C7D5z2CcAV9PoUoha+p/N9QZgtL2EuMMNn6PONJQ8pKMflPID0txKIr/oKxrDHhMi12P
         Rhu2JiHAHxFeEvQijYh2cYkl4oh2K40K1U/NZKHZpYj2GUw/VX73AlqpKoBNC6dhyuAy
         ePZg==
X-Gm-Message-State: AOJu0Ywb+AeK6vyDyC5sGM7ewPmVOzg18p/A8pwXd2PD5No9o55JA0Vc
	bvKvFl+2t1qqAgTtvU20D1L3nlAqJkNgrKtWcbEz3vLWCshmjjFBgGO59obd8SruGyc/AKaaL++
	NnzVF4GOWBaZA5aGWrfRLZMJLT6aUih4EKG2VwbqVPOzgdp5w956bqkDpI+z4jIlyCA88eg==
X-Gm-Gg: AfdE7cn5L4ew564XuI2JEOKOD88LDnM/+4rRNje5c1pNZItR71Kqzx36BRH7CFteeIB
	f2NPkNG0zhZznib1I2Tzwt/y1gFyp58OEN2yjxpOfYXyh6lZ7HPkIkTZjEehvBRVIshb8OsnNrs
	Nz291+1JYeDvf7OYQFv0Ih1cj6spaZ+3/bpxWR6YzPJvSvDTwFm/MY8RMJmw1AlOZDnbq0186ba
	3IPtkIxnz0goS/kez+r8gU/uJq7RSJ5pcYYkP1HJYdxyVUgk5Ng1MNgStwVYoM2PR0dPkLJsUWh
	0wxT0qEa5TtuNNt6ESw008hb0LJHoB+gjZ1lRfc8SZdX412Z5GKn7zq3qOPmLx73LywAzyhdYmJ
	9FHt1V9oDbpbU0dD5c8Ud6iHF6JYvOO0392y9Mb4=
X-Received: by 2002:a05:600c:c48e:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49260878c12mr73662355e9.27.1782336157135;
        Wed, 24 Jun 2026 14:22:37 -0700 (PDT)
X-Received: by 2002:a05:600c:c48e:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49260878c12mr73661975e9.27.1782336156646;
        Wed, 24 Jun 2026 14:22:36 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm10478201f8f.11.2026.06.24.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:22:36 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, Seesee <cjc000013@gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_set_pipapo: don't leak bad clone into
 future transaction
Message-ID: <20260624232234.27a3a883@elisabeth>
In-Reply-To: <ajxEbCY0yNsrsxx6@strlen.de>
References: <20260616191938.2875-1-fw@strlen.de>
	<20260617075123.7a62e22c@elisabeth>
	<ajJUklUUmvafRVi9@strlen.de>
	<ajxEbCY0yNsrsxx6@strlen.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Jun 2026 23:22:35 +0200 (CEST)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13456-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:cjc000013@gmail.com,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sbrivio@redhat.com,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF8906C16F3

On Wed, 24 Jun 2026 22:56:12 +0200
Florian Westphal <fw@strlen.de> wrote:

> Florian Westphal <fw@strlen.de> wrote:
> > Stefano Brivio <sbrivio@redhat.com> wrote:  
> > > I can try to get to this in the next few days (I would have some ideas
> > > about testing, see below), but I suppose we want a fix quickly if that's
> > > really the case so I'm actually fine with this, with one nit, also
> > > reported below.  
> > 
> > I don't mind, this can wait if you prefer to undo the state.  
> 
> Ping.  Are you working on an alternative patch or should I send a v2?

I've been working on it on and off but it's more complicated than I
thought (and I could find less time than I thought). Sorry. A v2 would
be very appreciated for the moment (but even v1 was okay I think).

-- 
Stefano




