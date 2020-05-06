Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24751C65EE
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 04:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgEFCjK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 May 2020 22:39:10 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44816 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728069AbgEFCjJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 May 2020 22:39:09 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id B2FC03A4142
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 12:39:06 +1000 (AEST)
Received: (qmail 27583 invoked by uid 501); 6 May 2020 02:39:06 -0000
Date:   Wed, 6 May 2020 12:39:06 +1000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue 0/3] pktbuff API updates
Message-ID: <20200506023906.GC26529@dimstar.local.net>
Mail-Followup-To: Netfilter Development <netfilter-devel@vger.kernel.org>
References: <20200428211452.GF15436@dimstar.local.net>
 <20200428225520.GA30421@salvia>
 <20200429132840.GA3833@dimstar.local.net>
 <20200429191047.GB3833@dimstar.local.net>
 <20200429191643.GA16749@salvia>
 <20200429203029.GD3833@dimstar.local.net>
 <20200429210512.GA14508@salvia>
 <20200430063404.GF3833@dimstar.local.net>
 <20200505123034.GA16780@salvia>
 <20200506005715.GA26529@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506005715.GA26529@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=RSmzAf-M6YYA:10
        a=qcjwsAYspEhFExEGJCsA:9 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 06, 2020 at 10:57:15AM +1000, Duncan Roe wrote:
[...]
> If zeroising is unnecessary then yes, we don't need 'extra'. pktb_mangle() can
> return 0 if 'buf_size' is inadequate. (pktb_alloc2() checks 'buf_size >=
> sizeof(struct pkt_buff)' and copies 'buf_size' into the enlarged 'pktb'
> so it's available to pktb_mangle()).

No need for new element - we already have data_len
>
> Cheeers ... Duncan.
