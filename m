Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03F31F172D
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2020 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgFHLBu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Jun 2020 07:01:50 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:48131 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729554AbgFHLBt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:01:49 -0400
Received: from popmini.vanrein.org ([IPv6:2001:980:93a5:1::7])
        by smtp-cloud7.xs4all.net with ESMTP
        id iFXGjMW6cNp2ziFXHjaaT9; Mon, 08 Jun 2020 13:01:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openfortress.nl; 
 i=rick@openfortress.nl; q=dns/txt; s=fame; t=1591614106; 
 h=message-id : date : from : mime-version : to : cc : 
 subject : references : in-reply-to : content-type : 
 content-transfer-encoding : date : from : subject; 
 bh=dnPhF9AuFbZnbeEEKO78qnfrbW7K13QNi8C/e0DN1cI=; 
 b=Pu1FRYcQAZXEMH8DMEL/VUVCZBLiLca5tnJm87bAoqLrgoQk0NeD9E6n
 zcCvW5IRvB1GmvN2xBAEqRGoBL1xiQJTkXwduQucwKWig/2ZxXbtUUroop
 i+51SaKt/UGhkJRtfjhQ2KhzeFTmEreCw9fxXL0wL5MPKrf94MTDeIyGQ=
Received: by fame.vanrein.org (Postfix, from userid 1006)
        id 5A0253CDD4; Mon,  8 Jun 2020 11:01:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from airhead.fritz.box (phantom.vanrein.org [83.161.146.46])
        by fame.vanrein.org (Postfix) with ESMTPA id 371463CF71;
        Mon,  8 Jun 2020 11:01:46 +0000 (UTC)
Message-ID: <5EDE1A8A.90004@openfortress.nl>
Date:   Mon, 08 Jun 2020 13:01:30 +0200
From:   Rick van Rein <rick@openfortress.nl>
User-Agent: Postbox 3.0.11 (Macintosh/20140602)
MIME-Version: 1.0
To:     Pablo Neira Ayuso <pablo@netfilter.org>
CC:     netfilter-devel@vger.kernel.org
Subject: Re: Expressive limitation: (daddr,dport) <--> (daddr',dport')
References: <5EDC7662.1070002@openfortress.nl> <20200607220810.GA6604@salvia> <5EDE0C9B.2020701@openfortress.nl> <20200608103140.GA15655@salvia>
In-Reply-To: <20200608103140.GA15655@salvia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.4
X-CMAE-Envelope: MS4wfHJPwrVmwm0+FsCS16I8L0eq2Nsr/GzciVAj24wtpCtmt/ma7sXbfgfgCyuP+1U2t84hn5kF1MUXoi2jKZ6q4iJdiOv0f3mem7ek+l/mDdEq6TnBdApm
 gwMZoMtvsLmBUyEs8u6A3gvV54dgsEUUAcf9rFLbkSTM0oHqmUUz/90ZKR768hDAZhJC5bfB+X4y3GE7RWZk1P+zYkoY5fQVHLo=
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Thanks for following up on this :)

>> The examples are just three syntaxes I can think of.
>
> OK, but you only need this "stack" idea is alternative proposal to get
> the "one single mapping" idea working, correct?

Yes, indeed.

-Rick
