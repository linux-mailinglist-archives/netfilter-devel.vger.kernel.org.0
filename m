Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5DF9901
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLSoN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 13:44:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSoM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:44:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57EAE60DCE; Tue, 12 Nov 2019 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573584252;
        bh=/yf4HL3zStzwUQL0TQMI6RLNGO89m82L0KRuZPZP5A8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=goKIJ51zwCYPaNIOAPGO0+D60E1MqEiYRyTLsm0Y3RVUGe1kkn85aaUqgLgvNjJZT
         Ii32cjZmpcQqBA6X33+9dfa4M1eqrp513pZEuwhgUzAjPFtEwN8HZT+s2A2gsZFLbp
         YQKKTWnfihQGrK5BwV140jcuHX6z2tqq3DQvPXaM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0A58660D97;
        Tue, 12 Nov 2019 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573584252;
        bh=/yf4HL3zStzwUQL0TQMI6RLNGO89m82L0KRuZPZP5A8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=goKIJ51zwCYPaNIOAPGO0+D60E1MqEiYRyTLsm0Y3RVUGe1kkn85aaUqgLgvNjJZT
         Ii32cjZmpcQqBA6X33+9dfa4M1eqrp513pZEuwhgUzAjPFtEwN8HZT+s2A2gsZFLbp
         YQKKTWnfihQGrK5BwV140jcuHX6z2tqq3DQvPXaM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Nov 2019 00:14:11 +0530
From:   manojbm@codeaurora.org
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, subashab@quicinc.com,
        sharathv@qti.qualcomm.com, ssaha@qti.qualcomm.com,
        vidulak@qti.qualcomm.com, bryanh@quicinc.com,
        jovanar@qti.qualcomm.com, manojbm@qti.qualcomm.com
Subject: Re: [PATCH] netfilter: xtables: Add snapshot of hardidletimer target
In-Reply-To: <20191112111424.GE19558@breakpoint.cc>
References: <20191111065617.GA29048@manojbm-linux.ap.qualcomm.com>
 <20191112111424.GE19558@breakpoint.cc>
Message-ID: <66396e8a52d8e348ec4638e3ead62490@codeaurora.org>
X-Sender: manojbm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 2019-11-12 16:44, Florian Westphal wrote:
> Manoj Basapathi <manojbm@codeaurora.org> wrote:
>> When the timer expires, the target module sends a sysfs notification
>> to the userspace, which can then decide what to do (eg. disconnect to
>> save power)
>> 
>> Compared to xt_IDLETIMER, xt_HARDIDLETIMER can send notifications when
>> CPU is in suspend too, to notify the timer expiry.
> 
> Would it make sense to add this feature to IDLETIMER instead of a new
> module? AFAICS there is a lot of boilerplate overlap between those two.

