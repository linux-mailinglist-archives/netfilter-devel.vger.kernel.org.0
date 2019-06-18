Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED64C49E6A
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jun 2019 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfFRKko (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jun 2019 06:40:44 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:51668 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728795AbfFRKkn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:40:43 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hdBXd-0007hK-Gh; Tue, 18 Jun 2019 12:40:41 +0200
Date:   Tue, 18 Jun 2019 12:40:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     =?utf-8?Q?=C4=B0brahim?= Ercan <ibrahim.metu@gmail.com>
Cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: Is this possible SYN Proxy bug?
Message-ID: <20190618104041.unuonhmuvgnlty3l@breakpoint.cc>
References: <CAK6Qs9mam2U6JdeBnkzX9sfdeWWkLx_+ZgHOTmYjSC2wKfg0cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK6Qs9mam2U6JdeBnkzX9sfdeWWkLx_+ZgHOTmYjSC2wKfg0cQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

İbrahim Ercan <ibrahim.metu@gmail.com> wrote:
> Until here there is nothing wrong. Now see what happen when I set
> client mss value to 1260 by changing mtu.
[..]

> Internal interface
> 10.0.0.215.60802 > 10.0.1.213.80: Flags [S], seq 36636545, win 197,
> options [mss 536,sackOK,TS val 99747035 ecr 6054999,nop,wscale 7],
> length 0
> 10.0.1.213.80 > 10.0.0.215.60802: Flags [S.], seq 3600660781, ack
> 36636546, win 14480, options [mss 1460,sackOK,TS val 16773019 ecr
> 99747035,nop,wscale 2], length 0
> 
> As you can see syn proxy respond to client with same mss value and
> open connection to back end with 536. But I suppose, It should send
> 1460 to client and 1260 to server.

Problem is that we do not keep any state.  Syncookes are restricted to 4
mss value:
static __u16 const msstab[] = {
 536,
1300,
1440,   /* 1440, 1452: PPPoE */
1460,
};

So, 1260 forces lowest value supported.

The table was based off a research paper that had mss distribution
tables.  Maybe more recent data is available and if things have changed
we could update the table accordingly.
