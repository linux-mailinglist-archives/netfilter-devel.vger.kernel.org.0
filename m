Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD69CC95
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfHZJ25 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 05:28:57 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:34087 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbfHZJ25 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:28:57 -0400
Received: from [47.60.32.119] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i2BIv-00031P-IG; Mon, 26 Aug 2019 11:28:55 +0200
Date:   Mon, 26 Aug 2019 11:28:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] netfilter: nft_meta: support for time matching
Message-ID: <20190826092847.kytxtceu2uy5j6jr@salvia>
References: <20190817111753.8756-1-a@juaristi.eus>
 <20190817111753.8756-2-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817111753.8756-2-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 17, 2019 at 01:17:53PM +0200, Ander Juaristi wrote:
> This patch introduces meta matches in the kernel for time (a UNIX timestamp),
> day (a day of week, represented as an integer between 0-6), and
> hour (an hour in the current day, or: number of seconds since midnight).
> 
> All values are taken as unsigned 64-bit integers.
> 
> The 'time' keyword is internally converted to nanoseconds by nft in
> userspace, and hence the timestamp is taken in nanoseconds as well.

Also applied, thanks.
