Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A74115C1B
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLGLwI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Dec 2019 06:52:08 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34408 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfLGLwI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:52:08 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1idYd4-0002Q1-Mo; Sat, 07 Dec 2019 12:52:06 +0100
Date:   Sat, 7 Dec 2019 12:52:06 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question (verdicts)
Message-ID: <20191207115206.GC795@breakpoint.cc>
References: <20191202102623.GA775@dimstar.local.net>
 <20191207012843.GA22674@dimstar.local.net>
 <20191207111645.GB795@breakpoint.cc>
 <20191207114909.GA928@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207114909.GA928@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> So are you saying that the existing documentation:
> > NF_STOP accept, but don't continue iterations
> can be more clearly expressed by something like:
> > NF_STOP accept, but skip any further base chains using the current hook
> ?

Yes, thats right.
