Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2380557E8
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 21:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfFYTk4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 15:40:56 -0400
Received: from mail.us.es ([193.147.175.20]:46860 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfFYTk4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:40:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 36488C3311
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:40:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 28598DA4CA
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:40:54 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1DED6DA801; Tue, 25 Jun 2019 21:40:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 18A67DA7B6;
        Tue, 25 Jun 2019 21:40:52 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 21:40:52 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E5D5D4265A31;
        Tue, 25 Jun 2019 21:40:51 +0200 (CEST)
Date:   Tue, 25 Jun 2019 21:40:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Felix Kaechele <felix@kaechele.ca>,
        Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH 08/13] netfilter: ctnetlink: Resolve conntrack
 L3-protocol flush regression
Message-ID: <20190625194051.vvpczvdubil2kkse@salvia>
References: <20190513095630.32443-1-pablo@netfilter.org>
 <20190513095630.32443-9-pablo@netfilter.org>
 <0a4e3cd2-82f7-8ad6-2403-9852e34c8ac3@kaechele.ca>
 <20190624235816.vw6ahepdgvxhvdej@salvia>
 <4367f30f-4602-a4b6-a96e-35d879cc7758@kaechele.ca>
 <20190625080853.d6f523cimgg2u44v@salvia>
 <0904a616-106c-91de-ed55-97973aa5c330@kaechele.ca>
 <CAKfDRXjun=cVovtn70jxwTc9pa0hhDHUSdZjLHJC1Xw2AMG+rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfDRXjun=cVovtn70jxwTc9pa0hhDHUSdZjLHJC1Xw2AMG+rA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:52:32PM +0200, Kristian Evensen wrote:
> Hi,
> 
> I am sorry for the trouble that my change has caused. I do not know
> what the correct action would be, but I am just trying to figure out
> what is going on. In your first email, you wrote:
> 
> > this patch is giving me some trouble as it breaks deletion of conntrack
> > entries in software that doesn't set the version flag to anything else
> > but 0.
> 
> I might be a bit slow, but I have some trouble understanding this
> sentence. Is what you are saying that software that sets version to
> anything but 0 breaks? According to the discussion triggered by the
> patch adding the feature that we fix here (see the thread [PATCH
> 07/31] netfilter: ctnetlink: Support L3 protocol-filter on flush),
> using the version field is the correct solution. Pablo wrote:
> 
> > The version field was meant to deal with this case.
> >
> > It has been not unused so far because we had no good reason.
> 
> So I guess Nicholas worry was correct, that there are applications
> that leave version uninitialized and they trigger the regression. I
> will let others decide if not setting version counts as a regression
> or incorrect API usage. If an uninitialized version counts as a
> regression, I am fine with reverting and will try to come up with
> another approach. However, I guess we now might have users that depend
> on the new behavior of flush as well.

What kind of application is leaving this uninitialized?

The software you're pointing to is using libnetfilter_conntrack.
