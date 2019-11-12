Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEDF8DBC
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfKLLO0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 06:14:26 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45442 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfKLLO0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:14:26 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iUU7s-0000pB-6b; Tue, 12 Nov 2019 12:14:24 +0100
Date:   Tue, 12 Nov 2019 12:14:24 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Manoj Basapathi <manojbm@codeaurora.org>
Cc:     netfilter-devel@vger.kernel.org, subashab@quicinc.com,
        sharathv@qti.qualcomm.com, ssaha@qti.qualcomm.com,
        vidulak@qti.qualcomm.com, bryanh@quicinc.com,
        jovanar@qti.qualcomm.com, manojbm@qti.qualcomm.com
Subject: Re: [PATCH] netfilter: xtables: Add snapshot of hardidletimer target
Message-ID: <20191112111424.GE19558@breakpoint.cc>
References: <20191111065617.GA29048@manojbm-linux.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111065617.GA29048@manojbm-linux.ap.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Manoj Basapathi <manojbm@codeaurora.org> wrote:
> When the timer expires, the target module sends a sysfs notification
> to the userspace, which can then decide what to do (eg. disconnect to
> save power)
> 
> Compared to xt_IDLETIMER, xt_HARDIDLETIMER can send notifications when
> CPU is in suspend too, to notify the timer expiry.

Would it make sense to add this feature to IDLETIMER instead of a new
module? AFAICS there is a lot of boilerplate overlap between those two.
