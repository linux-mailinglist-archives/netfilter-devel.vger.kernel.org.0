Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A119773F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHUKg6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 06:36:58 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:56919 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfHUKg6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:36:58 -0400
X-Greylist: delayed 1400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 06:36:58 EDT
Received: from [47.60.43.0] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i0NcR-0008Fb-5v; Wed, 21 Aug 2019 12:13:37 +0200
Date:   Wed, 21 Aug 2019 12:13:29 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Joseph C. Sible" <josephcsible@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables] doc: Note REDIRECT case of no IP address
Message-ID: <20190821094615.iskhx35wpbloyjht@salvia>
References: <CABpewhHgvi8TFqiBD6o_mksG0xLa5khYL2BbxaLhW6uhfOtHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABpewhHgvi8TFqiBD6o_mksG0xLa5khYL2BbxaLhW6uhfOtHMA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:26:25PM -0400, Joseph C. Sible wrote:
> If an IP packet comes in on an interface that lacks a corresponding IP
> address (which happens on, e.g., the veth's that Project Calico creates),
> attempting to use REDIRECT on it will cause it to be dropped. Take note
> of this in REDIRECT's documentation.

Applied, thanks.
