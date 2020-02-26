Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7569F16FDF9
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2020 12:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBZLjg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Feb 2020 06:39:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27966 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgBZLjg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582717176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cBmPrGrYaBT1HzFBa/2dqf0KmeNqCSjvBaf3dlo72GQ=;
        b=fuP4H1d/OV4203VSZhvCMWJsWdxBTxw0qPnKgObyI1/jaXGBgS8akB+4fAeRXqJgNHEOfn
        /7o5oZPeVpISbP01KOnluxWEUAdYIGIx0QOcRMO3H43gOt0+LdfLkOwjM3hM4QwvYG6eJ2
        H1v/mX6pT327BYHO+fUOZZOGynxppBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-vKWmP_yzNXKoPU0e3rRVaw-1; Wed, 26 Feb 2020 06:39:34 -0500
X-MC-Unique: vKWmP_yzNXKoPU0e3rRVaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251121088397;
        Wed, 26 Feb 2020 11:39:33 +0000 (UTC)
Received: from localhost (ovpn-200-34.brq.redhat.com [10.40.200.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 827E1100164D;
        Wed, 26 Feb 2020 11:39:31 +0000 (UTC)
Date:   Wed, 26 Feb 2020 12:39:26 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf 0/2] nft_set_pipapo: Fix crash due to dangling
 entries in mapping table
Message-ID: <20200226123926.3c5b1831@redhat.com>
In-Reply-To: <20200226113443.vudkkqzxj5qussqz@salvia>
References: <20200225123934.p3vru3tmbsjj2o7y@salvia>
        <20200225141346.7406e06b@redhat.com>
        <20200225134236.sdz5ujufvxm2in3h@salvia>
        <20200225153435.17319874@redhat.com>
        <20200225202143.tqsfhggvklvhnsvs@salvia>
        <20200225213815.3c0a1caa@redhat.com>
        <20200225205847.s5pjjp652unj6u7v@salvia>
        <20200226115924.461f2029@redhat.com>
        <20200226111056.5fultu3onan2vttd@salvia>
        <20200226121924.4194f31d@redhat.com>
        <20200226113443.vudkkqzxj5qussqz@salvia>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, 26 Feb 2020 12:34:43 +0100
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Wed, Feb 26, 2020 at 12:19:24PM +0100, Stefano Brivio wrote:
> > On Wed, 26 Feb 2020 12:10:56 +0100
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >   
> > > On Wed, Feb 26, 2020 at 11:59:24AM +0100, Stefano Brivio wrote:
> > > [...]  
> > > > One detail, unrelated to this patch, that I should probably document in
> > > > man pages and Wiki (I forgot, it occurred to me while testing): it is
> > > > allowed to insert an entry if a proper subset of it, with no
> > > > overlapping bounds, is already inserted. The reverse sequence is not
> > > > allowed. This can be used without ambiguity due to strict guarantees
> > > > about ordering. That is:
> > > > 
> > > > # nft add element t s '{ 1.0.0.20-1.0.0.21 . 3.3.3.3 }'
> > > > # nft add element t s '{ 1.0.0.10-1.0.0.100 . 3.3.3.3 }'    
> > > 
> > > OK, so first element "shadows" the second one. And the first element
> > > will matching in case that address is 1.0.0.20 and 10.0.0.21. Right?  
> > 
> > Correct.  
> 
> So this is happening because the result bitmap contains the pipapo
> rules that represent the first element and the second. But when
> iterating over the result bitmap bits, the pipapo rule that represents
> the first element is taken as the matching one, right?

Right.

> I mean, to catch elements that represents subsets/supersets of another
> element (like in this example above), pipapo would need to make a
> lookup for already matching rules for this new element?

Right, and that's what those two pipapo_get() calls in
nft_pipapo_insert() do.

-- 
Stefano

