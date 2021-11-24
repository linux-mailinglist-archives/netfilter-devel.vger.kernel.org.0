Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A451345CB36
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhKXRlt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 12:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhKXRlt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637775518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLUqX+NA205CZ8AVMNzH9C20UeQx+kT4jJesdTak08s=;
        b=Oa+09urAFtbWzOoIWjCgS9y4gTI4DnGYkoyPrQghml4Tmz1JQgk1tT1iY0hUEFnTBWKylU
        J0kvEkeqkPoynXUwtjBSbHkj+lCRAZgdML0Zj/Au1P0XPhCK+KI80GrUvazdX4pVbkVKRX
        eSSnhb3//CHZ/v4xu+0LyJ1lYU3kbI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-laaDgCz8PUGc712QxTOFbw-1; Wed, 24 Nov 2021 12:38:35 -0500
X-MC-Unique: laaDgCz8PUGc712QxTOFbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 812EF81CCBE;
        Wed, 24 Nov 2021 17:38:34 +0000 (UTC)
Received: from maya.cloud.tilaa.com (unknown [10.40.208.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2087460854;
        Wed, 24 Nov 2021 17:38:34 +0000 (UTC)
Date:   Wed, 24 Nov 2021 18:38:13 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc:     Florian Westphal <fw@strlen.de>, Netdev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, kernel@openvz.org
Subject: Re: "AVX2-based lookup implementation" has broken ebtables
 --among-src
Message-ID: <20211124183813.674dcf6a@elisabeth>
In-Reply-To: <20211122142933.15e6bffc@elisabeth>
References: <d35db9d6-0727-1296-fa78-4efeadf3319c@virtuozzo.com>
        <20211116173352.1a5ff66a@elisabeth>
        <20211117120609.GI6326@breakpoint.cc>
        <6d484385-5bf6-5cc5-4d26-fd90c367a2dc@virtuozzo.com>
        <20211122142933.15e6bffc@elisabeth>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, 22 Nov 2021 14:29:33 +0100
Stefano Brivio <sbrivio@redhat.com> wrote:

> On Wed, 17 Nov 2021 15:08:54 +0300
> Nikita Yushchenko <nikita.yushchenko@virtuozzo.com> wrote:
> 
> > >>> Looks like the AVX2-based lookup does not process this correctly.  
> > >>
> > >> Thanks for bisecting and reporting this! I'm looking into it now, I
> > >> might be a bit slow as I'm currently traveling.    
> > > 
> > > Might be a bug in ebtables....    
> > 
> > Exactly same ebtables binary (and exactly same rule) works with
> > kernel 4.18 and all kernels up to the mentioned patch applied.  
> 
> Sorry for the delay, I've been offline the past days, I'll restart
> looking into this now.

I'm still debugging this but, if it helps, I found another workaround
while checking: swapping the order of IP address and MAC address
"fixes" it -- unfortunately I didn't think of this while writing the
selftests, so that's what nft_concat_range.sh checks, a set with type
"net, mac", and not "mac, net". E.g.:

table ip t {
	set s {
		type ipv4_addr . ether_addr
		flags interval
		elements = { 192.168.122.1 . 52:54:00:04:9e:00 }
	}

	chain c {
		type filter hook input priority filter; policy accept;
		ip saddr . ether saddr @s counter packets 19 bytes 1284
	}
}

...of course this is due to an implementation detail (and the bug I'm
chasing), functionally it's expected to be the same.

-- 
Stefano

