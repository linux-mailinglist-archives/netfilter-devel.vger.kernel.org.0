Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3786B391B57
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 May 2021 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhEZPNk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 May 2021 11:13:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhEZPNg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 May 2021 11:13:36 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2046A1FD2A;
        Wed, 26 May 2021 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622041924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZelMBi4d95dvCUmWRUIP8TUgh65XTfMcJ3dRm9X0P1A=;
        b=qKIW90BS6Lde8vZIOsvQwyy6C3lSqIldIWgLLJITgrdXMR2gk4bjcOdAgfTdQuWk5YDPve
        MKesusZAY88RGqv8abbTzWnD8rh2WqVS2u/m7vdh5Mmns9MlQ62+WUA0/5Rkc9sRC8/GRW
        xIX82Fg0ihSSS1iCKgK38JfYKEZtwYY=
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id F24D611A98;
        Wed, 26 May 2021 15:12:03 +0000 (UTC)
Date:   Wed, 26 May 2021 17:12:03 +0200
From:   Ali Abdallah <ali.abdallah@suse.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: add new sysctl to disable RST check
Message-ID: <20210526151203.rncl2c2vu5hgc6fx@Fryzen495>
References: <20210526092444.lca726ghsrli5fpx@Fryzen495>
 <e48eac1e-dd8e-52c2-3a15-a9404933d1dd@6wind.com>
 <20210526143454.2x3riukvcz4b322s@Fryzen495>
 <97089f6c-9889-0824-8aea-6fada4a93b20@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97089f6c-9889-0824-8aea-6fada4a93b20@6wind.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 26.05.2021 17:06, Nicolas Dichtel wrote:
> Le 26/05/2021 à 16:34, Ali Abdallah a écrit :
> > That what the doc on nf_conntrack_tcp_be_liberal says as well, logically
> > not 0 is 1, so IMHO I don't think that can lead to confusion.
> 
> There is a lot of sysctl that have several magic values, see
> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> 
> And some act like boolean but accept all values,
> /proc/sys/net/ipv4/conf/*/forwarding for example.
> 
> There is nothing obvious with sysctl values (and a lot of inconsistencies), it's
> why I suggest to be explicit.

Yes, I absolutely see your point, and I have no problem in making that
explicit, I will sent a v2 patch saying explicitly that only "1" would
disable RST seq number checks, hopefully it gets merged soon.

> Regards,
> Nicolas

Kind Regards,
Ali


