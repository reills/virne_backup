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
  id 1961
  arrival_time 42944.584246404054
  lifetime 2501.1560832937853
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 10
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 37
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 21
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 44
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 20
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 29
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 3
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 19
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 0
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 10
    gpu 8
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 14
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
]
