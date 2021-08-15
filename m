Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591C73EC939
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Aug 2021 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhHONHu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Aug 2021 09:07:50 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53234 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhHONHu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:07:50 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 05AC860056;
        Sun, 15 Aug 2021 15:06:33 +0200 (CEST)
Date:   Sun, 15 Aug 2021 15:07:16 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     alexandre.ferrieux@orange.com
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: nfnetlink_queue -- why linear lookup ?
Message-ID: <20210815130716.GA21655@salvia>
References: <11790_1628855682_61165D82_11790_25_1_3f865faa-9fd8-40aa-6e49-5d85dd596b5b@orange.com>
 <20210814210103.GG607@breakpoint.cc>
 <14552_1628975094_61182FF6_14552_82_1_d4901cb2-0852-a524-436c-62bf06f95d0e@orange.com>
 <20210814211238.GH607@breakpoint.cc>
 <27263_1629029795_611905A3_27263_246_1_ddbb7a24-d843-9985-5833-c7c8c1aa8d29@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27263_1629029795_611905A3_27263_246_1_ddbb7a24-d843-9985-5833-c7c8c1aa8d29@orange.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 15, 2021 at 02:17:08PM +0200, alexandre.ferrieux@orange.com wrote:
[...]
> So, the only way forward would be a separate hashtable on ids.

Using the rhashtable implementation is fine for this, it's mostly
boilerplate code that is needed to use it and there are plenty of
examples in the kernel tree if you need a reference.

[...]
> PS: what is the intended dominant use case for batch verdicts ?

Issuing a batch containing several packets helps to amortize the
cost of the syscall.
