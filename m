Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E879CC93
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfHZJ2f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 05:28:35 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:36385 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbfHZJ2e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:28:34 -0400
Received: from [47.60.32.119] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i2BIZ-00030x-H1; Mon, 26 Aug 2019 11:28:33 +0200
Date:   Mon, 26 Aug 2019 11:28:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] netfilter: Introduce new 64-bit helper functions
Message-ID: <20190826090346.35gz4mds253tp2zd@salvia>
References: <20190817111753.8756-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817111753.8756-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 17, 2019 at 01:17:52PM +0200, Ander Juaristi wrote:
> Introduce new helper functions to load/store 64-bit values
> onto/from registers:
> 
>  - nft_reg_store64
>  - nft_reg_load64
> 
> This commit also re-orders all these helpers from smallest
> to largest target bit size.

Applied, thanks.
