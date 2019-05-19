Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13BA228AD
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 May 2019 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfESUOm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 May 2019 16:14:42 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:53942 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfESUOl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 May 2019 16:14:41 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSSCe-0004em-3G; Sun, 19 May 2019 22:14:40 +0200
Date:   Sun, 19 May 2019 22:14:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     =?iso-8859-15?Q?St=E9phane?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Expectations
Message-ID: <20190519201440.sb4ajpd6nuuczrkr@breakpoint.cc>
References: <CAFs+hh7TAWAG9T9kgB2SS8m-xcQQWD4ormR8VT98RXe84MQREg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFs+hh7TAWAG9T9kgB2SS8m-xcQQWD4ormR8VT98RXe84MQREg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stéphane Veyret <sveyret@gmail.com> wrote:
> I think I finished the work regarding expectations. I sent 4 patches
> (yesterday evening CEST) for 3 different projects : kernel, library
> and nft (now waiting for your feedback).
> I would like now to add a new helper module in the kernel to manage
> RTSP. Do you think it could be a good idea/useful thing?

RTSP looks rather complex, wouldn't it be better/simpler to use
a proxy?

We have TPROXY so we can intercept udp and tcp connections; we have
ctnetlink so the proxy could even inject expectations to keep the real
data in the kernel forwarding plane.
