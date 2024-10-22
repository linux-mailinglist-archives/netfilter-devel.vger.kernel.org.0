Return-Path: <netfilter-devel+bounces-4630-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5789A9F1F
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Oct 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BFE1F234A8
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Oct 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853A187864;
	Tue, 22 Oct 2024 09:49:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107531494CF
	for <netfilter-devel@vger.kernel.org>; Tue, 22 Oct 2024 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590564; cv=none; b=gi6N0lU6uQYMDeVav+QZW94AE77iNmwFGe8LTlSHKGM/NblyoWOMLSgwtmRNAyExrarZNWhvrqrxn6zut7e228HwowkfTn/w3tV714yMXsrbg639YU2PVKMSBQEItbIFwFi2RJ4hPKdlvFL+ezV17Dyg1Ct5RMnlHnyMJXUV+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590564; c=relaxed/simple;
	bh=1RsSvfd/EEWy5jilqLi3oMMlaP7CKypU8n65hBN/Ngw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7C25hirCJ3T92BzGT7/nrw5KIiRp/HCMmIKjSsrEI2QClmPrLGBt9kMMAl0rk++UndwSHtKJPjM1EzDbKDdcx+Vdtbgig3FzHYmavdm0k/qycaWDNBo81Qbwq7XWSZDMVUk/+pgn0EmaJh7eUdfECS4LFfk6UAVAmqkdXUWXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=47772 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1t3BVs-00DI8M-7m; Tue, 22 Oct 2024 11:49:18 +0200
Date: Tue, 22 Oct 2024 11:49:15 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jeremy Sowden <jeremy@azazel.net>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack,v2 2/2] conntrack: improve --mark parser
Message-ID: <Zxd1GxUMU1T6kOYa@calendula>
References: <20241012220030.51402-1-pablo@netfilter.org>
 <20241012220030.51402-2-pablo@netfilter.org>
 <20241021191056.GB1028786@celephais.dreamlands>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021191056.GB1028786@celephais.dreamlands>
X-Spam-Score: -1.9 (-)

On Mon, Oct 21, 2024 at 08:10:56PM +0100, Jeremy Sowden wrote:
> On 2024-10-13, at 00:00:30 +0200, Pablo Neira Ayuso wrote:
> > Enhance helper function to parse mark and mask (if available), bail out
> > if input is not correct.
> > 
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > v2: - remove value == 0 && errno == ERANGE check
> > 
> >  src/conntrack.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/src/conntrack.c b/src/conntrack.c
> > index 18829dbf79bc..5bd966cad657 100644
> > --- a/src/conntrack.c
> > +++ b/src/conntrack.c
> > @@ -1233,17 +1233,35 @@ static int parse_value(const char *str, uint32_t *ret, uint64_t max)
> >  	return 0;
> >  }
> >  
> > -static void
> > +static int
> >  parse_u32_mask(const char *arg, struct u32_mask *m)
> >  {
> > -	char *end;
> > +	uint64_t val, mask;
> > +	char *endptr;
> > +
> > +	val = strtoul(arg, &endptr, 0);
> > +	if (endptr == arg ||
> > +	    (*endptr != '\0' && *endptr != '/') ||
> > +	    (val == ULONG_MAX && errno == ERANGE) ||
> > +	    val > UINT32_MAX)
> > +		return -1;
> >  
> > -	m->value = (uint32_t) strtoul(arg, &end, 0);
> > +	m->value = val;
> >  
> > -	if (*end == '/')
> > -		m->mask = (uint32_t) strtoul(end+1, NULL, 0);
> > -	else
> > +	if (*endptr == '/') {
> > +		mask = (uint32_t) strtoul(endptr + 1, &endptr, 0);
>                        ^^^^^^^^^^
> 
> No need for this cast.

Amended and pushed out, thanks.

