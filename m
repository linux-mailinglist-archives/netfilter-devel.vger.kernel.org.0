Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234C71B054A
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2020 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgDTJNG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Apr 2020 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgDTJNF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:13:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADEC061A0C
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2020 02:13:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so10125359wmj.1
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2020 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEBvGrCb2g0tNb1/FO2xMXc+cURxztL4dKH2M30BK4o=;
        b=R+WkaJCRmsCQq18vepmRu4TTin6hYBa8NCkKXApyo6lERAgWB/5Uwcy9T1hmnrUT7X
         W55fMqtgzp3gDCNFxl4rX0KhjLhyXduS2QjNN9unOvvjAejnRyS0lWed4GngG5/6fEA1
         7SYigWYyo87QUJNESzYCiWJXRpBpFWcMkKt16xiH2ylxZYDEzFDMy3uAcSV8zCDFOl/c
         kqWGcvRnQGbeEo5YupgB0MW3VQGeErjevOx6H5osfPDAaYLx9W+qyRw141zIeu66mXVY
         hvAe4905k0etBX91EJ58Je55ymPkE+lw1Cl4vaUhWFndL/n0uHyAhWhSz1Bkc8/ksoE8
         QRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEBvGrCb2g0tNb1/FO2xMXc+cURxztL4dKH2M30BK4o=;
        b=phh22XWMrcerrR3Qmp16l+PivNdi6hMgyjUrvxri8xDCJ7bPpMgvTvDwM30hHtkwu+
         01H0ZYhVXFUGflODUDWeY8n6ubSdLYqyddha332IG+/3EvvcAd5Yed7SUS8dUNWfs9/a
         tMuAXzzHH59i/9J9pibUoWGgJIwta1WSTABctRzAAZ8sUiII5/55dAnfIv1gJN6/QXxV
         htDGcXFx+qtBHlkHUvDcc/0lu8AAnMBGhVcEvAC/Xx1suYxR6xRHfBoiF6ECQTv/MDik
         32aEGsRltWV4/QlKiGgWhli7kOoEqwd/39vz8cQXfpAxaNWpVGhuyQwXwl85ZMiZeTtW
         pW4g==
X-Gm-Message-State: AGi0PuZOXU9geGvceQlixgeWWzEsEJbYwMiPDMGvmVV5Sc7mYRhIaOuH
        pei6SFgsy28ePvQob2N6fGOzTA==
X-Google-Smtp-Source: APiQypL4Lh9y2flQzsA4Ls93xXlr8SAYLqpQuidjDr5k6fkExZ2RM2BQfq967/CvApPqp1H8ztSinQ==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr17707394wmy.13.1587373984298;
        Mon, 20 Apr 2020 02:13:04 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id p5sm393236wrg.49.2020.04.20.02.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 02:13:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:13:02 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] net: flow_offload: skip hw stats check for
 FLOW_ACTION_HW_STATS_DISABLED
Message-ID: <20200420091302.GB6581@nanopsycho.orion>
References: <20200419115338.659487-1-pablo@netfilter.org>
 <20200420080200.GA6581@nanopsycho.orion>
 <20200420090505.pr6wsunozfh7afaj@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420090505.pr6wsunozfh7afaj@salvia>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mon, Apr 20, 2020 at 11:05:05AM CEST, pablo@netfilter.org wrote:
>On Mon, Apr 20, 2020 at 10:02:00AM +0200, Jiri Pirko wrote:
>> Sun, Apr 19, 2020 at 01:53:38PM CEST, pablo@netfilter.org wrote:
>> >If the frontend requests no stats through FLOW_ACTION_HW_STATS_DISABLED,
>> >drivers that are checking for the hw stats configuration bail out with
>> >EOPNOTSUPP.
>> 
>> Wait, that was a point. Driver has to support stats disabling.
>
>Hm, some drivers used to accept FLOW_ACTION_HW_STATS_DISABLED, now
>rulesets that used to work don't work anymore.

How? This check is here since the introduction of hw stats types.
