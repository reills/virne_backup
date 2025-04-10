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
  id 1953
  arrival_time 42834.44299196667
  lifetime 2448.005168463302
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 41
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 35
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 32
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 35
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 9
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 4
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 47
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 19
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 19
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 38
    rom 29
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 41
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 11
    gpu 37
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 15
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 1
  ]
]
