Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45312A8DC
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Dec 2019 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYS00 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Dec 2019 13:26:26 -0500
Received: from rain.florz.de ([185.139.32.146]:42341 "EHLO rain.florz.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLYS0Z (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:26:25 -0500
Received: from [2a07:12c0:1c00:43::121] (port=58614 helo=florz.florz.de)
        by rain.florz.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA256:256)
        (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1ikBMU-0005EE-EK; Wed, 25 Dec 2019 19:26:22 +0100
Received: from florz by florz.florz.de with local (Exim 4.89)
        (envelope-from <florz@florz.de>)
        id 1ikBMR-0005P1-6v; Wed, 25 Dec 2019 19:26:19 +0100
Date:   Wed, 25 Dec 2019 19:26:19 +0100
From:   Florian Zumbiehl <florz@florz.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nftables] bug: rejects single-element intervals as supposedly
 empty
Message-ID: <20191225182619.sci3ifx4yr6d4mhd@florz.florz.de>
Mail-Followup-To: netfilter-devel@vger.kernel.org, florz@florz.de
References: <20191225154106.x6mmx3m6hi7ksrao@florz.florz.de>
 <20191225175023.GG795@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225175023.GG795@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

> > | # nft add rule foo bar udp dport 1-1
> > | Error: Range has zero or negative size
> > | add rule foo bar udp dport 1-1
> 
> I'd guess this is intentional and nft assumes user
> meant something else such as 1-2 or 1-11.

Well, I would hope it is not intentional to claim that a one-element set
has zero or fewer elements!?

> We could autotranslate this to "dport 1" but I'm not sure its right.

Well, I don't know enough about the internals to know whether "translation"
is the right thing to do, but I would think the intended meaning (i.e.,
match port 1) is obvious, so that is what should happen?

Second-guessing the user on input that would seem obviously valid and
well-defined based on the documentation certainly doesn't seem like a good
idea to me. Just because there is a possibly more efficient way to encode
the same rule doesn't seem like a good reason to reject this encoding, as
that just complicates everything, and especially any code interfacing with
this, as you then have to special-case all those cases instead of just
generating a universal format that can represent all possible cases.

Also, nft accepts 1.2.3.4/32 just fine, or 1.2.3.0-1.2.3.255, which both
could be encoded more efficiently as well.

Regards, Florian
