Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5819012A8B5
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Dec 2019 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLYRuZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Dec 2019 12:50:25 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:60984 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbfLYRuZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Dec 2019 12:50:25 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ikAnf-0001au-Mc; Wed, 25 Dec 2019 18:50:23 +0100
Date:   Wed, 25 Dec 2019 18:50:23 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel@vger.kernel.org, florz@florz.de
Subject: Re: [nftables] bug: rejects single-element intervals as supposedly
 empty
Message-ID: <20191225175023.GG795@breakpoint.cc>
References: <20191225154106.x6mmx3m6hi7ksrao@florz.florz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225154106.x6mmx3m6hi7ksrao@florz.florz.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Zumbiehl <florz@florz.de> wrote:
> I stumbled upon this bug in the Debian buster backports version of nftables
> (0.9.2-1~bpo10+1), the git commit log doesn't look like this has been fixed
> since, so here it is:
> 
> | # nft add rule foo bar udp dport 1-1
> | Error: Range has zero or negative size
> | add rule foo bar udp dport 1-1

I'd guess this is intentional and nft assumes user
meant something else such as 1-2 or 1-11.

We could autotranslate this to "dport 1" but I'm not sure its right.
