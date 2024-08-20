Return-Path: <netfilter-devel+bounces-3373-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB99577F1
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2024 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD3828360D
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495A1DD39F;
	Mon, 19 Aug 2024 22:41:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7214B945
	for <netfilter-devel@vger.kernel.org>; Mon, 19 Aug 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107300; cv=none; b=M9zhfWy3wsXmh8hJqdZ4tBweHUBiA6OFF4SvqSDWKTR+m+S0qJVauNipo8NAwvdUcUts0tFQbQiQ5NJPMq9JvsBobq7PJMtBT7ecIAC+C+kN5hBtI+nUrRfllCIo+bTYp7Br+uAg37SZl9BxnB7gN4tObGmiwmlpD9ILRNh1peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107300; c=relaxed/simple;
	bh=dr5ziwJdpwmEnUj6gCSEY9iTSz9JDgD99wazLAAOTX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs3cwnT2mVru3SicMoH+AXebhWFe3dRpiHarejYGVLCFtJPAcTbVlVDEeMczi2V+oLuKI4Hu4gNDob1BnXW70QsZ9QAUZk3rD3ZRkSYyr4I0frztBoSFZvXP5KFj1fSCE2rmKzt+7H1kyBonNRu5nj4vwazhF7YynH5CRsY7RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=52004 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sgB48-005yj9-3k; Tue, 20 Aug 2024 00:41:35 +0200
Date: Tue, 20 Aug 2024 00:41:31 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Thomas Haller <thaller@redhat.com>
Cc: NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/5] datatype: make "flags" field of datatype struct
 simple booleans
Message-ID: <ZsPKGwpXBFwdK61c@calendula>
References: <20230927200143.3798124-1-thaller@redhat.com>
 <20230927200143.3798124-2-thaller@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927200143.3798124-2-thaller@redhat.com>
X-Spam-Score: -1.9 (-)

On Wed, Sep 27, 2023 at 09:57:24PM +0200, Thomas Haller wrote:
> Flags are not always bad. For example, as a function argument they allow
> easier extension in the future. But with datatype's "flags" argument and
> enum datatype_flags there are no advantages of this approach.
> 
> - replace DTYPE_F_PREFIX with a "bool f_prefix:1" field.
> 
> - replace DTYPE_F_ALLOC with a "bool f_alloc:1" field.
> 
> - the new boolean fields are made bitfields, although for the moment
>   that does not reduce the size of the struct. If we add more flags,
>   that will be different.

For the record, I followed a different approach to replace these:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20240819221834.972153-1-pablo@netfilter.org/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20240819221834.972153-2-pablo@netfilter.org/

