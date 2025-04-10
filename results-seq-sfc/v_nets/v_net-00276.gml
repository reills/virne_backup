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
  id 276
  arrival_time 5303.543836181565
  lifetime 278.6162892347378
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 9
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 24
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 17
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 34
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 49
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 27
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 42
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 18
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 29
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 21
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 32
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 41
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
]
