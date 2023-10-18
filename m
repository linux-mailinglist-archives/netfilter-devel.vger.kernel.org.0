Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15D7CD010
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJQWfx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Oct 2023 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQWfw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E87BA
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Oct 2023 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697582103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K14VK3LJrvZTKbDfZ9yssU/T9TEMntiQjUmwdUEjFwA=;
        b=gJAsuH9a+3ONf1OpiMJH8k63NfXZAXvvhJgXI5bzrSzizuXOYOfy6Ug2X/molOcydxfrGi
        6vsQWjCWM0uHoeCQcSLtb3iCFpMch4Q6Pv98KcQuXHIlOOCel7ObtC+jUwAX+TV1bKJWcJ
        bb6JHqB0g+gtPPZIXj1lck6uclk0/aw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-Ia4pYuMKNPeEkogfEPsBqA-1; Tue, 17 Oct 2023 18:35:01 -0400
X-MC-Unique: Ia4pYuMKNPeEkogfEPsBqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F328185A797
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Oct 2023 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1832C15BB8;
        Tue, 17 Oct 2023 22:35:00 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 1/1] tests/shell: add NFT_TEST_FAIL_ON_SKIP_EXCEPT for allow-list of skipped tests (XFAIL)
Date:   Wed, 18 Oct 2023 00:33:29 +0200
Message-ID: <20231017223450.2613981-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Some tests cannot pass, for example due to missing kernel features or
kernel bugs. The tests make an educated guess (feature detection),
whether the failure is due to that, and marks the test as SKIP (exit
77). The problem is, the test might guess wrong and hide a real issue.

Add support for a NFT_TEST_FAIL_ON_SKIP_EXCEPT= regex to help with this.
Together with NFT_TEST_FAIL_ON_SKIP=y is enabled, test names that match
the regex are allowed to be skipped. Unexpected skips are treated as
fatal. This allows to maintain a list of tests that are known to be
skipped.

You can think of this as some sort of XFAIL/XPASS mechanism. The
difference is that usually XFAIL is part of the test. Here the failure
happens due to external conditions, as such you need to configure
NFT_TEST_FAIL_ON_SKIP_EXCEPT= per kernel. Also, usually XFAIL is about
failing tests, while this is about tests that are marked to be skipped.
But we mark them as skipped due to a heuristic, and those we want to
manually keep track off.

Why is NFT_TEST_FAIL_ON_SKIP_EXCEPT= useful and why doesn't it just work
automatically? It does work automatically (see use case 1 below).  Trust
the automatism to the right thing, and don't bother. This is when you
don't trust the automatism and you curate a list of tests that are known
to be be skipped, but no others (see use case 3 below). In particular,
it's for running CI on a downstream kernel, where we expect a static
list of skipped tests and where we want to find any changes.

Consider this: there are three use case for running the tests.

  1) The contributor, who wants to run the test suite. The tests make a
  best effort to pass and when the test detects that the failure is
  likely due to the kernel, then it will skip the test. This is the
  default.

  2) The maintainer, who runs latest kernel and expects that all tests are
  passing. Any SKIP is likely a bug. This is achieved by setting
  NFT_TEST_FAIL_ON_SKIP=y.

  3) The downstream maintainer, who test a distro kernel that is known to
  lack certain features. They know that a selected few tests should be
  skipped, but most tests should pass. By setting NFT_TEST_FAIL_ON_SKIP=y
  and NFT_TEST_FAIL_ON_SKIP_EXCEPT= they can specify which are expected to
  be skipped. The regex is kernel/environment specific, and must be
  actively curated.

  BONUS) actually, cases 2) and 3) optimally run automated CI tests.
  Then the test environment is defined with a particular kernel variant
  and changes slowly over time. NFT_TEST_FAIL_ON_SKIP_EXCEPT= allows
  to pick up any unexpected changes of the skipped/pass behavior of
  tests.

If a test matches the regex but passes, this is also flagged as a
failure ([XPASS]). The user is required to maintain an accurate list of
XFAIL tests.

Example:

  $ NFT_TEST_FAIL_ON_SKIP=y \
    NFT_TEST_FAIL_ON_SKIP_EXCEPT='^(tests/shell/testcases/nft-f/0017ct_timeout_obj_0|tests/shell/testcases/listing/0020flowtable_0)$' \
    ./tests/shell/run-tests.sh \
          tests/shell/testcases/nft-f/0017ct_timeout_obj_0 \
          tests/shell/testcases/cache/0006_cache_table_flush \
          tests/shell/testcases/listing/0013objects_0 \
          tests/shell/testcases/listing/0020flowtable_0
  ...
  I: [SKIPPED]     1/4 tests/shell/testcases/nft-f/0017ct_timeout_obj_0
  I: [OK]          2/4 tests/shell/testcases/cache/0006_cache_table_flush
  W: [FAIL-SKIP]   3/4 tests/shell/testcases/listing/0013objects_0
  W: [XPASS]       4/4 tests/shell/testcases/listing/0020flowtable_0

This list of XFAIL tests is maintainable, because on a particular
downstream kernel, the number of tests known to be skipped is small and
relatively static. Also, you can generate the list easily (followed by
manual verification!) via

  $ NFT_TEST_FAIL_ON_SKIP=n ./tests/shell/run-tests.sh -k
  $ export NFT_TEST_FAIL_ON_SKIP_EXCEPT="$(cat /tmp/nft-test.latest.*/skip-if-fail-except)"
  $ NFT_TEST_FAIL_ON_SKIP=y ./tests/shell/run-tests.sh

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
Sorry for the overly long commit message. I hope it can be useful and
speak in favor of the patch (and not against it).

This is related to the "eval-exit-code" patch, as it's about how to
handle tests that are SKIPed. But it's relevant for any skipped test,
and not tied to that work.

 tests/shell/helpers/test-wrapper.sh | 41 +++++++++++++++++++++
 tests/shell/run-tests.sh            | 55 ++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/tests/shell/helpers/test-wrapper.sh b/tests/shell/helpers/test-wrapper.sh
index 13b918f8b8e1..e8edb7332d24 100755
--- a/tests/shell/helpers/test-wrapper.sh
+++ b/tests/shell/helpers/test-wrapper.sh
@@ -176,10 +176,49 @@ if [ "$tainted_before" != "$tainted_after" ] ; then
 	rc_tainted=1
 fi
 
+rc_fail_on_skip=0
+rc_fail_on_skip_xpass=0
+if [ "$NFT_TEST_FAIL_ON_SKIP" = y ] ; then
+	if [ -n "${NFT_TEST_FAIL_ON_SKIP_EXCEPT+x}" ] ; then
+
+		OLD_IFS="$IFS"
+		IFS=$'\n'
+		REGEXES=( $NFT_TEST_FAIL_ON_SKIP_EXCEPT )
+		IFS="$OLD_IFST"
+
+		re_match=0
+		for re in "${REGEXES[@]}" ; do
+			if [[ "$TEST" =~ $re ]] ; then
+				re_match=1
+				break;
+			fi
+		done
+
+		if [ "$re_match" -eq 1 ] ; then
+			if [ "$rc_test" -eq 0 ] ; then
+				echo "test passed although expected to be skipped (XPASS) by regex NFT_TEST_FAIL_ON_SKIP_EXCEPT /$NFT_TEST_FAIL_ON_SKIP_EXCEPT/" > "$NFT_TEST_TESTTMPDIR/rc-failed-skip"
+				rc_fail_on_skip_xpass=1
+			fi
+		else
+			if [ "$rc_test" -eq 77 ] ; then
+				echo "upgrade skip to failure due to NFT_TEST_FAIL_ON_SKIP. Regex NFT_TEST_FAIL_ON_SKIP_EXCEPT /$NFT_TEST_FAIL_ON_SKIP_EXCEPT/ does not match" > "$NFT_TEST_TESTTMPDIR/rc-failed-skip"
+				rc_fail_on_skip=1
+			fi
+		fi
+	else
+		if [ "$rc_test" -eq 77 ] ; then
+			echo "upgrade skip to failure due to NFT_TEST_FAIL_ON_SKIP" > "$NFT_TEST_TESTTMPDIR/rc-failed-skip"
+			rc_fail_on_skip=1
+		fi
+	fi
+fi
+
 if [ "$rc_valgrind" -ne 0 ] ; then
 	rc_exit=122
 elif [ "$rc_tainted" -ne 0 ] ; then
 	rc_exit=123
+elif [ "$rc_fail_on_skip" -ne 0 ] ; then
+	rc_exit=120
 elif [ "$rc_test" -ge 118 -a "$rc_test" -le 124 ] ; then
 	# Special exit codes are reserved. Coerce them.
 	rc_exit=125
@@ -189,6 +228,8 @@ elif [ "$rc_dump" -ne 0 ] ; then
 	rc_exit=124
 elif [ "$rc_chkdump" -ne 0 ] ; then
 	rc_exit=121
+elif [ "$rc_fail_on_skip_xpass" -ne 0 ] ; then
+	rc_exit=119
 else
 	rc_exit=0
 fi
diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index 22105c2e90e2..8fceb2795113 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -221,6 +221,10 @@ usage() {
 	echo "                 kernel modules)."
 	echo "                 Parallel jobs requires unshare and are disabled with NFT_TEST_UNSHARE_CMD=\"\"."
 	echo " NFT_TEST_FAIL_ON_SKIP=*|y: if any jobs are skipped, exit with error."
+	echo " NFT_TEST_FAIL_ON_SKIP_EXCEPT=<regex>: only honored with NFT_TEST_FAIL_ON_SKIP=y. This is a regex for"
+	echo "                 tests for which a skip is expected and not fatal (XFAIL). Multiple regex can be separated by"
+	echo "                 newline. This allows that skip a selected set of known tests, while all other tests must pass."
+	echo "                 If a test passes but matches the regex, it is treated as failure too (XPASS)."
 	echo " NFT_TEST_RANDOM_SEED=<SEED>: The test runner will export the environment variable NFT_TEST_RANDOM_SEED"
 	echo "                 set to a random number. This can be used as a stable seed for tests to randomize behavior."
 	echo "                 Set this to a fixed value to get reproducible behavior."
@@ -305,6 +309,8 @@ export NFT_TEST_RANDOM_SEED
 
 TESTS=()
 
+TESTS_SKIP_EXCEPT=()
+
 SETUP_HOST=
 SETUP_HOST_OTHER=
 
@@ -639,6 +645,11 @@ msg_info "conf: NFT_TEST_HAS_UNSHARED_MOUNT=$(printf '%q' "$NFT_TEST_HAS_UNSHARE
 msg_info "conf: NFT_TEST_KEEP_LOGS=$(printf '%q' "$NFT_TEST_KEEP_LOGS")"
 msg_info "conf: NFT_TEST_JOBS=$NFT_TEST_JOBS"
 msg_info "conf: NFT_TEST_FAIL_ON_SKIP=$NFT_TEST_FAIL_ON_SKIP"
+if [ -z "${NFT_TEST_FAIL_ON_SKIP_EXCEPT+x}" ] ; then
+	msg_info "conf: # NFT_TEST_FAIL_ON_SKIP_EXCEPT unset"
+else
+	msg_info "conf: NFT_TEST_FAIL_ON_SKIP_EXCEPT=$(printf '%q' "$NFT_TEST_FAIL_ON_SKIP_EXCEPT")"
+fi
 msg_info "conf: NFT_TEST_RANDOM_SEED=$NFT_TEST_RANDOM_SEED"
 msg_info "conf: NFT_TEST_SHUFFLE_TESTS=$NFT_TEST_SHUFFLE_TESTS"
 msg_info "conf: TMPDIR=$(printf '%q' "$_TMPDIR")"
@@ -707,6 +718,7 @@ kernel_cleanup() {
 echo ""
 ok=0
 skipped=0
+skipped_as_fail=0
 failed=0
 
 kmem_runs=0
@@ -767,7 +779,7 @@ print_test_header() {
 	align_text text right "${#s_idx}" "$testidx_completed"
 	s_idx="$text/${#TESTS[@]}"
 
-	align_text text left 12 "[$status]"
+	align_text text left 13 "[$status]"
 	_msg "$msglevel" "$text $s_idx $testfile"
 }
 
@@ -786,10 +798,19 @@ print_test_result() {
 	elif [ "$rc_got" -eq 77 ] ; then
 		((skipped++))
 		result_msg_status="${YELLOW}SKIPPED$RESET"
+		TESTS_SKIP_EXCEPT+=( "^$testfile$" )
 	else
 		((failed++))
 		result_msg_level="W"
-		if [ "$rc_got" -eq 121 ] ; then
+		if [ "$rc_got" -eq 119 ] ; then
+			# This means, the test passed, but it was matched by NFT_TEST_FAIL_ON_SKIP_EXCEPT regex.
+			# The regex is expected to match *exactly* the tests that are skipped. An unexpected PASS
+			# is also treated as a failure. Inspect NFT_TEST_FAIL_ON_SKIP_EXCEPT regex.
+			result_msg_status="XPASS"
+		elif [ "$rc_got" -eq 120 ] ; then
+			((skipped_as_fail++))
+			result_msg_status="FAIL-SKIP"
+		elif [ "$rc_got" -eq 121 ] ; then
 			result_msg_status="CHK DUMP"
 		elif [ "$rc_got" -eq 122 ] ; then
 			result_msg_status="VALGRIND"
@@ -831,8 +852,14 @@ job_start() {
 		print_test_header I "$testfile" "$testidx" "EXECUTING"
 	fi
 
+	# NFT_TEST_FAIL_ON_SKIP_EXCEPT is already exported, if it happens to be set.
 	NFT_TEST_TESTTMPDIR="${JOBS_TEMPDIR["$testfile"]}" \
-	NFT="$NFT" NFT_REAL="$NFT_REAL" DIFF="$DIFF" DUMPGEN="$DUMPGEN" $NFT_TEST_UNSHARE_CMD "$NFT_TEST_BASEDIR/helpers/test-wrapper.sh" "$testfile"
+	NFT="$NFT" \
+	NFT_REAL="$NFT_REAL" \
+	DIFF="$DIFF" \
+	DUMPGEN="$DUMPGEN" \
+	NFT_TEST_FAIL_ON_SKIP="$NFT_TEST_FAIL_ON_SKIP" \
+	$NFT_TEST_UNSHARE_CMD "$NFT_TEST_BASEDIR/helpers/test-wrapper.sh" "$testfile"
 	local rc_got=$?
 
 	if [ "$NFT_TEST_JOBS" -le 1 ] ; then
@@ -896,12 +923,7 @@ echo ""
 kmemleak_found=0
 check_kmemleak_force
 
-failed_total="$failed"
-if [ "$NFT_TEST_FAIL_ON_SKIP" = y ] ; then
-	failed_total="$((failed_total + skipped))"
-fi
-
-if [ "$failed_total" -gt 0 ] ; then
+if [ "$failed" -gt 0 ] ; then
 	RR="$RED"
 elif [ "$skipped" -gt 0 ] ; then
 	RR="$YELLOW"
@@ -926,17 +948,24 @@ END_TIME="$(cut -d ' ' -f1 /proc/uptime)"
 WALL_TIME="$(awk -v start="$START_TIME" -v end="$END_TIME" "BEGIN { print(end - start) }")"
 printf "%s\n" "$WALL_TIME" "$START_TIME" "$END_TIME" > "$NFT_TEST_TMPDIR/times"
 
-if [ "$failed_total" -gt 0 -o "$NFT_TEST_KEEP_LOGS" = y ] ; then
+if [ "${#TESTS_SKIP_EXCEPT[@]}" -gt 0 ] ; then
+	printf '%s\n' "${TESTS_SKIP_EXCEPT[@]}" | sort
+fi > "$NFT_TEST_TMPDIR/skip-if-fail-except"
+
+if [ "$failed" -gt 0 -o "$NFT_TEST_KEEP_LOGS" = y ] ; then
 	msg_info "check the temp directory \"$NFT_TEST_TMPDIR\" (\"$NFT_TEST_LATEST\")"
 	msg_info "   ls -lad \"$NFT_TEST_LATEST\"/*/*"
 	msg_info "   grep -R ^ \"$NFT_TEST_LATEST\"/"
+	if [ "${#TESTS_SKIP_EXCEPT[@]}" -gt 0 ] ; then
+		msg_info "   generate XFAIL with NFT_TEST_FAIL_ON_SKIP_EXCEPT=\"\$(cat $NFT_TEST_LATEST/skip-if-fail-except)\""
+	fi
 	NFT_TEST_TMPDIR=
 fi
 
-if [ "$failed" -gt 0 ] ; then
+if [ "$failed" -gt 0 -a "$skipped_as_fail" -eq "$failed" ] ; then
+	msg_info "Tests were skipped, but failed due to NFT_TEST_FAIL_ON_SKIP=y"
 	exit 1
-elif [ "$NFT_TEST_FAIL_ON_SKIP" = y -a "$skipped" -gt 0 ] ; then
-	msg_info "some tests were skipped. Fail due to NFT_TEST_FAIL_ON_SKIP=y"
+elif [ "$failed" -gt 0 ] ; then
 	exit 1
 elif [ "$ok" -eq 0 -a "$skipped" -gt 0 ] ; then
 	exit 77
-- 
2.41.0

