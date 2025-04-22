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
  id 965
  arrival_time 20491.47216098855
  lifetime 1282.6476622063253
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 13
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 40
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 39
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 37
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 30
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 39
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 18
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 41
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 5
    rom 31
  ]
  node [
    id 9
    label "9"
    cpu 2
    gpu 19
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 32
    rom 48
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 33
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
]
