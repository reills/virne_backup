graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 737
  arrival_time 15483.046108862609
  lifetime 649.8408747597863
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 20
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 11
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 28
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 9
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 50
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 44
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 26
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 29
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 19
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 41
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 4
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 44
    rom 1
  ]
  node [
    id 12
    label "12"
    cpu 9
    gpu 37
    rom 42
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 19
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
]
