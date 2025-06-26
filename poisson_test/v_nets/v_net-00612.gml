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
  id 612
  arrival_time 12749.21396602427
  lifetime 2376.798926040874
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 1
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 48
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 30
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 16
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 41
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 38
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 27
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 49
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 11
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 8
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 39
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 34
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 0
    rom 23
  ]
  node [
    id 13
    label "13"
    cpu 8
    gpu 44
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
  edge [
    source 12
    target 13
    bw 21
  ]
]
