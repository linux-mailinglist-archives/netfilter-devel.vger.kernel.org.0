Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC4D25EBD4
	for <lists+netfilter-devel@lfdr.de>; Sun,  6 Sep 2020 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIFASW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 5 Sep 2020 20:18:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42636 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgIFASW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 5 Sep 2020 20:18:22 -0400
Received: from dimstar.local.net (n49-192-221-78.sun4.vic.optusnet.com.au [49.192.221.78])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 122373A7BF8
        for <netfilter-devel@vger.kernel.org>; Sun,  6 Sep 2020 10:18:18 +1000 (AEST)
Received: (qmail 22224 invoked by uid 501); 6 Sep 2020 00:18:17 -0000
Date:   Sun, 6 Sep 2020 10:18:17 +1000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Can someone please update libnetfilter_queue online documentation
Message-ID: <20200906001817.GB6585@dimstar.local.net>
Mail-Followup-To: Netfilter Development <netfilter-devel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=6xKf4iIoQv62Sz4byRKdFA==:117 a=6xKf4iIoQv62Sz4byRKdFA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=RSmzAf-M6YYA:10 a=3HDBlxybAAAA:8
        a=2iCmBLDIqrXrismR8BEA:9 a=CjuIK1q_8ugA:10 a=3ZB0DOFoXBkA:10
        a=QPIECt7LLFIA:10 a=laEoCiVfU_Unz3mSdgXN:22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi everyone,

The online doc for libnetfilter_queue at
https://netfilter.org/projects/libnetfilter_queue/doxygen/html/ is still at
release 1.0.3.

Documentation forms a large part of release 1.0.4 / 1.0.5, so can someone please
build 1.0.5 doc and put it up?

You only need to do './configure --with-doxygen; make' and you have it.

Cheers ... Duncan.
