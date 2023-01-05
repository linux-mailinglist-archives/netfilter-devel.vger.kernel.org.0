Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE865EA39
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Jan 2023 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAELyG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Jan 2023 06:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAELyF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:54:05 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D15944C78
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Jan 2023 03:54:04 -0800 (PST)
Date:   Thu, 5 Jan 2023 12:53:58 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Long Xin <lxin@redhat.com>,
        Claudio Porfiri <claudio.porfiri@ericsson.com>
Subject: Re: [RFC PATCH] netfilter: conntrack: simplify sctp state machine
Message-ID: <Y7a6VqqMmW191RIG@salvia>
References: <20230104113143.21769-1-sriram.yagnaraman@est.tech>
 <Y7WVAEky9Iy3Ri3T@salvia>
 <DBBP189MB1433F79520D32E1CB0F8A62A95FA9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBP189MB1433F79520D32E1CB0F8A62A95FA9@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:41:13AM +0000, Sriram Yagnaraman wrote:
> > -----Original Message-----
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > Sent: Wednesday, 4 January 2023 16:02
> > To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> > Cc: netfilter-devel@vger.kernel.org; Florian Westphal <fw@strlen.de>;
> > Marcelo Ricardo Leitner <mleitner@redhat.com>; Long Xin
> > <lxin@redhat.com>
> > Subject: Re: [RFC PATCH] netfilter: conntrack: simplify sctp state machine
> > 
> > On Wed, Jan 04, 2023 at 12:31:43PM +0100, Sriram Yagnaraman wrote:
> > > All the paths in an SCTP connection are kept alive either by actual
> > > DATA/SACK running through the connection or by HEARTBEAT. This patch
> > > proposes a simple state machine with only two states OPEN_WAIT and
> > > ESTABLISHED (similar to UDP). The reason for this change is a full
> > > stateful approach to SCTP is difficult when the association is
> > > multihomed since the endpoints could use different paths in the
> > > network during the lifetime of an association.
> > 
> > Do you mean the router/firewall might not see all packets for association is
> > multihomed?
> > 
> > Could you please provide an example?
> 
> Let's say the primary and alternate/secondary paths between the SCTP
> endpoints traverse different middle boxes. If an SCTP endpoint
> detects network failure on the primary path, it will switch to using
> the secondary path and all subsequent packets will not be seen by
> the middlebox on the primary path, including SHUTDOWN sequences if
> they happen at that time.

OK, then on the primary middle box the SCTP flow will just timeout?
(because no more packets are seen).

Or the scenario you describe is this? Assuming a middle box that is an
alternate/secondary path, then such middle box (which did not see any
other packets before for this connection) starts seeing packets for
this flow, so packets are dropped by the secondary middle box (which
now became the primary path after the network failure)?
